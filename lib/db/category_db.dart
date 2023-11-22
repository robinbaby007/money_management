import 'package:sqflite/sqflite.dart';

import '../utils/const.dart';
import 'category_db_functions.dart';

late Database categoryDb;

class CategoryDb extends CategoryDbFunctionsImpl{

    Future<void> initCategoryDb() async {
    categoryDb = await openDatabase("category.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $categoryTable (id INTEGER PRIMARY KEY, name TEXT, isAvailable INTEGER, type INTEGER)');

    });
    getCategoryList();
  }
}
