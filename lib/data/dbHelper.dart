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
        join(await getDatabasesPath(), 'yap_database_te.db'),
        version: 1, onCreate: (db, version) async {
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

  Future<void> addSubject(Subject subject) {}
}
