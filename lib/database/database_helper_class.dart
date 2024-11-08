import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:healio/model/medicine_model.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'medicine.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE medicines( 
            id TEXT PRIMARY KEY, 
            commercialName TEXT, 
            medicalName TEXT, 
            dosage TEXT, 
            type TEXT, 
            category TEXT, 
            description TEXT, 
            imageUrl TEXT, 
            sideEffects TEXT, 
            precautions TEXT, 
            interactions TEXT 
          ) 
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add the missing column 'medicalName' in the onUpgrade method
          await db.execute('''
            ALTER TABLE medicines ADD COLUMN medicalName TEXT; 
          ''');
        }
      },
    );
  }

  static Future<bool> isMedicineSaved(String medicineId) async {
    final db = await DatabaseHelper.database;
    var result = await db.query(
      'medicines', // Correct table name here
      where: 'id = ?',
      whereArgs: [medicineId], // Use the String id here directly
    );
    return result.isNotEmpty;
  }

  // Insert a medicine into the database
  static Future<int> insertMedicine(Medicine medicine) async {
    final db = await DatabaseHelper.database;
    var result = await db.insert(
      'medicines', // Correct table name here
      {
        'id': medicine.id,
        'commercialName': medicine.commercialName,
        'medicalName': medicine.medicalName, // Include this field
        'dosage': medicine.dosage,
        'type': medicine.type,
        'category': medicine.category,
        'description': medicine.description,
        'imageUrl': medicine.imageUrl,
        'sideEffects': medicine.sideEffects,
        'precautions': medicine.precautions,
        'interactions': medicine.interactions,
      },
    );
    return result;
  }

  // Retrieve all medicines from the database
  static Future<List<Medicine>> getMedicines() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('medicines'); // Correct table name here

    return List.generate(maps.length, (i) {
      return Medicine.fromMap(maps[i]);
    });
  }

  // Delete a medicine from the database
  static Future<void> deleteMedicine(String id) async {
    final db = await database;
    await db.delete(
      'medicines', // Correct table name here
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
