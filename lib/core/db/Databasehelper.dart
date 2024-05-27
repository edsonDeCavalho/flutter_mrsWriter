import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehelper {
  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'mrs_writerdatabase.db');
    return openDatabase(path, version: 1, onCreate: _createdatabase);
  }

  static Future<void> _createdatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      jsonfilename TEXT
      )
    ''');
  }

  static Future<int> insertNote(String title, String description, String jsonFilename) async {
    final db = await _openDatabase();
    final data = {
      'title': title,
      'description': description,
      'jsonFilename': jsonFilename,
    };
    return await db.insert('notes', data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await _openDatabase();
    return await db.query('notes');
  }

  static Future<int> deleteNoteById(int id) async {
    final db = await _openDatabase();
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
