import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/models/subject.dart';
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
        join(await getDatabasesPath(), 'yap_database_9.db'),
        version: 1,
        //enable cascade delete
        onConfigure: (db) async => await db.execute(SQLTables.pragmaForeingKey),
        onCreate: (db, version) async {
          //Create required tables
          await db.execute(SQLTables.userTable);
          await db.execute(SQLTables.subjectTable);
          await db.execute(SQLTables.subjectTodoTable);
          await db.execute(SQLTables.todosTable);
          await db.execute(SQLTables.friendsTable);

          print("new SQLite database created ");
        });
  }

  Future<void> singOut() {
    database.then((db) async {
      await db.delete("user");
    });
  }

  Future<void> saveUser(User user) async {
    final Database db = await database;
    int rowID = await db.insert("user", user.toMap());
  }

  Future<User> getCurrentUser() async {
    final Database db = await database;
    //Avoid null Result
    List<Map> listOfUsersMap = await db.rawQuery("SELECT * FROM user ");
    User user = listOfUsersMap.isEmpty ? null : User.fromMap(listOfUsersMap[0]);
    print("local sqflite user consumed " + user.toString());
    return user;
  }

  Future<void> removeUnusedTags() async {
    //Karşılığı olmayan todoları sil
    final Database db = await database;
    await db.execute(
        "DELETE FROM todos WHERE id NOT IN (SELECT f.todo_id FROM subject_todos f)");
  }

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
      *
      *
      *
      * */
        //Create subject to map with all required fields
        int userID = user.id;
        Map<String, dynamic> mapToAddedTable = {"user_id": userID};
        mapToAddedTable.addAll(subject.toSubjectMap());
        int subjectID = await txn.insert("subject", mapToAddedTable);
        print("DBHELPER subject added");

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
                  where: '"name" = ?', whereArgs: [tagMap["name"]]);
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
        //return subjectID;
      },
    );
  }

  Future<List<Subject>> getAllSubjects() async {
    final Database db = await database;
    //to Hold created subjects
    List<Subject> listOfSubjects = <Subject>[];
    Subject subject;
    int subjectID;
    List<Map<String, dynamic>> subjectTagsMap;
    //gel all subject maps
    List<Map> subjectListMap = await db.query("subject");

    if (subjectListMap.isEmpty) {
      return null;
    }
    //If not return Subject Objects
    await Future.forEach(subjectListMap, (subjectMap) async {
      //convert SubjectMap to Subject object
      subject = Subject.fromMap(subjectMap);
      subjectID = subject.id;
      //Get tags List<map> from local
      subjectTagsMap = await getTagsBySubjectID(subjectID);

      //Add each tag to Subject object
      await Future.forEach(
          subjectTagsMap, (mapOfTag) => subject.tags.add(mapOfTag["name"]));
      listOfSubjects.add(subject);
    });

    return listOfSubjects;
  }

  Future<Set<String>> getAllTags() async {
    final Database db = await database;
    Set<String> tags = <String>{};
    List<Map> listOfTagMaps = await db.query("tags");
    if (listOfTagMaps.isEmpty) {
      return null;
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
        WHERE s.id =  $subjectID ''');
  }
}
