import 'package:sqflite/sqflite.dart';

import '../utils/const.dart';
import '../utils/global_variables.dart';
import 'category_db_functions.dart';


class CategoryDb{

    Future<void> initCategoryDb() async {
    categoryDb = await openDatabase("category.db", version: 1,
        onCreate: (Database db, int version) async {

      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    });

  }
}
