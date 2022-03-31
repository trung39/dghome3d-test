import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/app_user.dart';

class DataProvider {

  final String _tableName;
  final String _id = "uid";
  final String _name = "name";
  final String _phoneNumber = "phone_number";
  final String _email = "email";
  final String _expirationTime = "expiration_time";

  /// The test data used for testing
  final SqfliteTestData? testData;

  /// Construct DataProvider.
  /// If [testData] is provided, this provider is used for testing with given [testData]
  DataProvider({this.testData})
      : assert(testData == null || testData.testTableName.isNotEmpty,
            "Table name should not be empty"),
        _tableName = testData?.testTableName ?? "users";

  bool get isTesting => testData != null;
  Future<Database> getDatabase() async {
    if (isTesting) {
      return testData!.testDatabase;
    }
    return await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'user_database.db'),
      // When the database is first created, create a table to store todos.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE $_tableName('
              '$_id TEXT PRIMARY KEY, '
              '$_name TEXT, '
              '$_phoneNumber TEXT, '
              '$_email TEXT, '
              '$_expirationTime INT)',
        );
      },
      version: 1,
    );
  }

  /// Function to get user in database
  ///
  Future<AppUser?> getUser() async {
    final database = await getDatabase();

    // Query the table for all The Todos.
    final List<Map<String, dynamic>> maps = await database.query(_tableName);

    List<AppUser> userList = List.generate(maps.length, (i) {
      return AppUser.fromJson(maps[i]);
    });
    if (userList.isNotEmpty) {
      return userList.first;
    }
    return null;
  }

  /// Function to insert a new ToDo into database, with the given [toDo]
  ///
  Future<int> saveLoginUser(AppUser appUser) async {
    final database = await getDatabase();

    return await database.insert(
      _tableName,
      appUser.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Function to delete user from database
  Future<int> removeUser() async {
    final database = await getDatabase();

    // Remove the AppUser from the database.
    return await database.delete(
      _tableName,
      where: '$_id <> ?',
      whereArgs: [""],
    );
  }
}

class SqfliteTestData {
  Database testDatabase;
  String testTableName;

  SqfliteTestData({required this.testDatabase, required this.testTableName});
}