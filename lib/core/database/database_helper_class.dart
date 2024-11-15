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

    return openDatabase(path, version: 2, onCreate: (db, version) async {
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

      // Create 'reminders' table (same schema as medicines)
      await db.execute('''
          CREATE TABLE reminders( 
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
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 3) {
        try {
          await db.execute('''
        ALTER TABLE reminders ADD COLUMN commercialName TEXT;
      ''');
        } catch (e) {
          print('Error adding commercialName column: $e');
        }

        try {
          await db.execute('''
        ALTER TABLE reminders ADD COLUMN medicalName TEXT;
      ''');
        } catch (e) {
          print('Error adding medicalName column: $e');
        }
      }
    });
  }

  static Future<bool> isMedicineSaved(String medicineId) async {
    final db = await DatabaseHelper.database;
    var result = await db.query(
      'medicines',
      where: 'id = ?',
      whereArgs: [medicineId],
    );
    return result.isNotEmpty;
  }

  // Insert a medicine into the database
  static Future<int> insertMedicine(Medicine medicine) async {
    final db = await DatabaseHelper.database;
    var result = await db.insert(
      'medicines',
      {
        'id': medicine.id,
        'commercialName': medicine.commercialName,
        'medicalName': medicine.medicalName,
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
    final List<Map<String, dynamic>> maps = await db.query('medicines');

    return List.generate(maps.length, (i) {
      return Medicine.fromMap(maps[i]);
    });
  }

  // Delete a medicine from the database
  static Future<void> deleteMedicine(String id) async {
    final db = await database;
    await db.delete(
      'medicines',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> insertReminder(Medicine medicine) async {
    final db = await DatabaseHelper.database;
    var result = await db.insert(
      'reminders',
      {
        'id': medicine.id,
        'commercialName': medicine.commercialName,
        'medicalName': medicine.medicalName,
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
    print('Inserted medicine into reminders: $result');
    return result;
  }

// Helper method to check if a medicine is saved in reminders
  static Future<bool> isMedicineInReminders(String medicineId) async {
    final db = await DatabaseHelper.database;
    var result = await db.query(
      'reminders',
      where: 'id = ?',
      whereArgs: [medicineId],
    );
    return result.isNotEmpty;
  }

// Method to fetch all reminders
  static Future<List<Medicine>> getReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reminders');

    print('Fetched reminders: ${maps.length}');
    return List.generate(maps.length, (i) {
      return Medicine.fromMap(maps[i]);
    });
  }

  // Method to delete a reminder by ID
  static Future<void> deleteReminder(String id) async {
    final db = await database;
    await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
