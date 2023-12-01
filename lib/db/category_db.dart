import 'package:sqflite/sqflite.dart';

import '../utils/const.dart';
import '../utils/global_variables.dart';

class CategoryDb {
  CategoryDb._catDbConstructor();

  static final CategoryDb instance = CategoryDb._catDbConstructor();

  factory CategoryDb() {
    return instance;
  }

  late Database categoryDb;

  Database getCategoryDb() {
    return categoryDb;
  }

  Future<void> initCategoryDb() async {
    categoryDb = await openDatabase("category.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $categoryTable (id INTEGER PRIMARY KEY, name TEXT, isAvailable INTEGER, type INTEGER)');
    });
  }
}
