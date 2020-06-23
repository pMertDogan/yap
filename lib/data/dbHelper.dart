import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/data/models/user.dart';
import 'package:todo/utility/sqlTables.dart';

class DatabaseHelper {
  //Move to DAL files?
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'yap_database_p6.db'),
        version: 1,
        //enable cascade delete
        onConfigure: (db) async => await db.execute(SQLTables.pragmaForeingKey),
        onCreate: (db, version) async {
          //Create required tables
          await db.execute(SQLTables.userTable);
          await db.execute(SQLTables.subjectTable);
          await db.execute(SQLTables.subjectTagsTable);
          await db.execute(SQLTables.tagsTable);
          await db.execute(SQLTables.friendsTable);
          await db.execute(SQLTables.subjectContributorsTable);
          await db.execute(SQLTables.todosTable);
          print("DBHELPER new SQLite database created ");
        });
  }

  Future<void> singOut() async {
    //Maybe its not await, test it :)
    database.then((db) async {
      await db.transaction((txn) async {
        await txn.delete("user");
        await txn.delete("friends");
        await txn.delete("tags");
      });
    });
  }

  //user
  Future<void> saveUser(User user) async {
    await database
      ..transaction((txn) async {
        //save user
        await txn.insert("user", user.toMap());
        //save friends
        Future.forEach(
            user.friends,
            (Friend friend) async =>
                await txn.insert("friends", friend.toMap()));
      });
  }

  Future<User> getCurrentUser() async {
    final Database db = await database;
    //Avoid null Result
    List<Map> listOfUsersMap = await db.rawQuery("SELECT * FROM user ");
    User user;
    if (listOfUsersMap.isNotEmpty) {
      //select first user
      user = User.fromMap(listOfUsersMap[0]);
      // get friend list
      List<Map<String, dynamic>> friendList =
          await db.rawQuery("SELECT * FROM friends ");
      user.friends = List.generate(
              friendList.length, (index) => Friend.fromMap(friendList[index]))
          .toSet();
      print("DBHELPER getCurrentUser user friends count " +
          user.friends.length.toString());
    }
    print("local sqflite user consumed " + user.toString());
    return user;
  }

//Subject
  Future<void> addSubject(Subject subject) async {
    final Database db = await database;
    //Learn user ID
    User user = await getCurrentUser();
    //Start transaction
    await db.transaction(
      (txn) async {
        /*
      *   Add subject primitive values to subject Table
      *   Add subject tags to tags Table
      *   Connect subject and tags table with many yo many relationship
      *   add friends to table
      *
      *
      * */
        //Create subject to map with all required fields
        int userID = user.id;
        Map<String, dynamic> mapToAddedTable = {"user_id": userID};

        // add subject
        mapToAddedTable.addAll(subject.toSubjectMap());
        int subjectID = await txn.insert("subject", mapToAddedTable);
        //Store inserted tags ids
        List<int> idsOfTags = <int>[];
        List<Map<String, String>> tagsMapList = subject.toTagsMap();
        //Add each new tag to tags Table
        if (tagsMapList.isNotEmpty) {
          // normal forEach is not work with async
          await Future.forEach(tagsMapList,
              ((Map<String, String> tagMap) async {
            //ignore old tags with ConflictAlgorithm
            int addedID = await txn.insert("tags", tagMap,
                conflictAlgorithm: ConflictAlgorithm.ignore);
            if (addedID != null) {
              idsOfTags.add(addedID);
            } else {
              //Retrive already added tag ID
              List<Map> tagResult = await txn.query("tags",
                  //where: '"name" = ?', whereArgs: [tagMap["name"]]);
                  where: "name = ?",
                  whereArgs: [tagMap["name"]]);
              idsOfTags.add(tagResult[0]["id"]);
            }
          }));
        }
        //Many to many Subject <> TAGS
        await Future.forEach(
          idsOfTags,
          (tagID) async {
            Map<String, dynamic> tagToMap = {
              "subject_id": subjectID,
              "tag_id": tagID
            };
            await txn.insert("subject_tags", tagToMap);
          },
        );
        //To Do operation
        await Future.forEach(subject.toDoList, (ToDo todo) {
          Map<String, dynamic> todoMap = todo.toMap();
          todoMap["subject_id"] = subjectID;
          return txn.insert("todos", todoMap);
        });
        //subject_contributors
        print("contributors  dbHelper");
        await Future.forEach(subject.contributors, (Friend contributor) async {
          Map<String, dynamic> contributorToMap = {
            "subject_id": subjectID,
            "friend_id": contributor.id
          };
          await txn.insert("subject_contributors", contributorToMap);
        });
        print("contributors end  dbHelper");
      },
    );
  }

  Future<List<Subject>> getSubjects(
      {String startDate, Set<String> tags, String orderBy}) async {
    //['Priority', 'End Date', 'New', 'Old']
    String convertedOrderBy;
    if (orderBy == "Priority") {
      convertedOrderBy = "ORDER BY s.priority DESC";
    } else if (orderBy == "End Date") {
      convertedOrderBy = "ORDER BY s.end_date DESC";
    } else if (orderBy == "Recent") {
      convertedOrderBy = "ORDER BY s.start_date ASC";
    } else if (orderBy == "Old") {
      convertedOrderBy = "ORDER BY s.start_date DESC";
    }

    print("DBHELPER getAllSubject called ");
    final Database db = await database;
    //to Hold created subjects
    List<Subject> listOfSubjects = <Subject>[];
    Subject subject;
    int subjectID;
    List<Map<String, dynamic>> subjectTagsMap;
    //gel all subject maps
    List<Map> subjectListMap = <Map>[];
    if (startDate == null && tags == null) {
      //get all subjects
      String sqlQery = 'SELECT * FROM subject s ${convertedOrderBy ?? ""} ';
      subjectListMap = await db.rawQuery(sqlQery);
      //TODO add orderBY
    }
    //
    else if (tags != null) {
      String sql = '''
            SELECT s.id,
                   s.user_id,
                   s.title,
                   s.explanation,
                   s.pic_url,
                   s.pic_local,
                   s.start_date,
                   s.start_time,
                   s.end_date,
                   s.end_time,
                   s.priority,
                   s.completed,
                   s.lat,
                   s.lng,
                   s.location_name,
                   s.favorite FROM subject s
                   LEFT OUTER JOIN
                   subject_tags st ON st.subject_id = s.id
                   LEFT OUTER JOIN
                   tags t ON t.id = st.tag_id
                   ''';
//             WHERE s.start_date = "$startDate"
//             AND (t.name IN("${tags.join('","')}") OR tag_id IS NULL)
//             GROUP BY s.id;
//             ORDER BY XXX ASC;
//       ''';
      sql += startDate != null || tags != null ? ' WHERE ' : "";
      sql += startDate != null ? ' s.start_date = "$startDate" ' : "";
      sql += startDate != null && tags != null ? " AND " : "";
      sql += startDate != null || tags != null
          ? '(t.name IN("${tags.join('","')}") OR tag_id IS NULL)'
          : "";
      sql += ' GROUP BY s.id';
      sql += orderBy == null ? "" : " $convertedOrderBy";

      subjectListMap = await db.rawQuery(sql);
    } else if (startDate != null) {
      subjectListMap = await db
          .rawQuery("Select * FROM subject s WHERE start_date = '$startDate' "
              "${orderBy == null ? "" : " $convertedOrderBy"}");
    }

    //if there is no subject return empty list
    if (subjectListMap.isEmpty) {
      return <Subject>[];
    }
    //If not return Subject Objects
    await Future.forEach(subjectListMap, (subjectMap) async {
      //convert SubjectMap to Subject object
      subject = Subject.fromMap(subjectMap);
      subjectID = subject.id;
      //Get tags List<map> from local
      subjectTagsMap = await getTagsBySubjectID(subjectID);
      //Add each tag to Subject object
      await Future.forEach(subjectTagsMap, (mapOfTag) {
        subject.tags.add(mapOfTag["name"]);
      });
      //to do
      subject.toDoList = await getToDosBySubjectID(subjectID);
      // contributors
      subject.contributors = await getContributorsByID(subjectID);
      listOfSubjects.add(subject);
    });
    print("DBHelper number of subjects : " + listOfSubjects.length.toString());

    return listOfSubjects;
  }

  Future<List> getAllSubjectStartDates() async {
    int totalSubject = 0;
    List<String> subjectsStartDates = <String>[];
    List<int> totalSubjectForEachStartDate = <int>[];
    //Raw SQL code for Group by
    String sql = ''' 
    SELECT start_date,
    count(start_date) AS total_subject
    FROM subject s
    GROUP BY start_date
    ORDER BY s.start_date ASC
    ''';
    //get DB then start operation
    await database.then((db) async {
      List<Map> groupedSubjects = await db.rawQuery(sql);
      //Get information using Group by
      await Future.forEach(groupedSubjects, (element) {
        subjectsStartDates.add(element["start_date"]);
        totalSubjectForEachStartDate.add(element["total_subject"]);
        return totalSubject += element["total_subject"];
      });
    });
    List<dynamic> resultList = [
      subjectsStartDates,
      totalSubjectForEachStartDate
    ];
    return resultList;
  }

  Future<void> updateFavoriteStatus(int subjectID, bool favoriteStatus) async {
    //1 0 => true false
    Map<String, int> updatedFavorite = {"favorite": favoriteStatus ? 0 : 1};
    Database db = await database;
    await db.update("subject", updatedFavorite,
        where: '"id" = ?', whereArgs: [subjectID]);
  }

  Future<void> deleteSubjectByID(int subjectID) async {
    //TODO check
    await database.then((db) async {
      await db.delete("subject", where: '"id" = ?', whereArgs: [subjectID]);
    });
  }
//TAGS

  Future<void> updateSubjectTags(int subjectID, Set<String> subjectTags) async {
    database.then((db) {
      db.transaction((txn) async {
        //first delete current tags
        await txn.delete("subject_tags",
            where: '"subject_id"= ?', whereArgs: [subjectID]);
        //Than add all tags to table
        await Future.forEach(subjectTags, (tag) async {
          List<Map<String, dynamic>> result;
          result =
              await txn.query("tags", where: '"name" = ?', whereArgs: [tag]);
          int id;
          //if there is no tag using this name
          if (result.isEmpty) {
            //insert tag to table
            id = await txn.insert("tags", {"name": tag});
          } else {
            //tags exists use 0. item id
            id = result[0]["id"];
          }
          await txn
              .insert("subject_tags", {"subject_id": subjectID, "tag_id": id});
        });
      });
    });
  }

  Future<void> removeUnusedTags() async {
    //remove unused tags
    final Database db = await database;
    await db.execute(
        "DELETE FROM tags WHERE id NOT IN (SELECT tag_id FROM subject_tags);");
  }

  Future<Set<String>> getAllTags() async {
    final Database db = await database;
    Set<String> tags = <String>{};
    List<Map> listOfTagMaps = await db.query("tags");
    if (listOfTagMaps.isEmpty) {
      return <String>{};
    }
    await Future.forEach(listOfTagMaps, (element) => tags.add(element["name"]));
    return tags;
  }

  Future<List<Map<String, dynamic>>> getTagsBySubjectID(int subjectID) async {
    final Database db = await database;
    return await db.rawQuery('''
        SELECT t.name FROM subject s
        INNER JOIN subject_tags st ON
        s.id = st.subject_id
        JOIN tags t ON
        st.tag_id = t.id
        WHERE s.id =  $subjectID 
        ''');
  }

//TO DOS
  Future<List<ToDo>> getToDosBySubjectID(int subjectID) async {
    final Database db = await database;
    List<ToDo> todosList = <ToDo>[];
    List<Map<String, dynamic>> todosMapList = await db
        .query("todos", where: "subject_id = ?", whereArgs: [subjectID]);
    Future.forEach(
        todosMapList, (element) => todosList.add(ToDo.fromMap(element)));
    return todosList;
  }

  Future<void> updateToDoStatus(int todoID, bool status) async {
    database.then((db) {
      return db.update("todos", {"completed": status ? 0 : 1},
          where: '"id"= ?', whereArgs: [todoID]);
    });
  }

  Future<int> addToDoToSubject(ToDo toDo, int subjectId) async {
    if (toDo.id == null) {
      print("be carefull! there is no TODO ıd provieded");
    }
    //add subject_id field to todo.tomap for query
    Map<String, dynamic> fixedQueryMap = toDo.toMap()
      ..["subject_id"] = subjectId;
    Database db = await database;
    return await db.insert("todos", fixedQueryMap);
  }

  Future<void> deleteToDoById(int todoID) async {
    await database.then((db) async {
      await db.delete("todos", where: '"id"=?', whereArgs: [todoID]);
    });
  }

// Contributors aka Friends
  Future<List<Friend>> getContributorsByID(int subjectID) async {
    final Database db = await database;
    //print("subject id " + subjectID.toString());
    List contributorsListMap = await db.rawQuery('''
    SELECT f.id,
           f.email,
           f.name,
           f.photo_local,
           f.photo_url
      FROM subject s
           JOIN
           subject_contributors sc ON sc.subject_id = s.id
           JOIN
           friends f ON f.id = sc.friend_id
       WHERE s.id =  $subjectID;
    ''');
    //print("lenght of contributors " + contributorsListMap.length.toString());
    return List.generate(contributorsListMap.length,
        (index) => Friend.fromMap(contributorsListMap[index]));
  }

  Future<void> updateSubjectContributors(
      List<Friend> updatedContributors, int subjecID) async {
    database.then((db) {
      db.transaction((txn) async {
        //remove olds
        await txn.delete("subject_contributors",
            where: '"subject_id" = ?', whereArgs: [subjecID]);
        //add news
        await Future.forEach(
            updatedContributors,
            (Friend contributors) async => await txn.insert(
                "subject_contributors",
                {"subject_id": subjecID, "friend_id": contributors.id}));
      });
    });
  }

  Future<void> addFriend(Friend friend) async {
    final Database db = await database;
    await db.insert("friends", friend.toMap());
  }
}
