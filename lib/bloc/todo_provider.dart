import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todo.dart';

class TodoProvider {
  static final TodoProvider _todoProvider = TodoProvider._internal();
  TodoProvider._internal();

  factory TodoProvider() {
    return _todoProvider;
  }

  Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  String tableName = 'todo_table';

  initDB() async {
    String path = join(await getDatabasesPath(), 'database.db');
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, done INTEGER, data TEXT)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );
  }

  Future<void> insert(Todo todo) async {
    final db = await database;
    await db.insert(
      tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> getListByDate(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM $tableName WHERE date = ?', [date]);
    if (maps.isEmpty) return [];
    List<Todo> list = [];
    for (var i = 0; i < maps.length; i++) {
      list.add(Todo(
        id: maps[i]["id"],
        date: DateTime.parse(maps[i]["date"]),
        done: maps[i]["done"],
        data: maps[i]["data"],
      ));
    }
    return list;
  }

  Future<void> setDoneById(int id, int checked) async {
    final db = await database;

    await db
        .rawQuery('UPDATE $tableName SET done = $checked WHERE id = ?', [id]);
  }
}
