import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';
import '../screens/category/Category.dart';
import '../utils/const.dart';
import 'category_db.dart';

abstract class CategoryDbFunctions {
  Future<void> getCategoryList();

  Future<void> addToCategory(CategoryModel categoryModel);
}

ValueNotifier<List<CategoryModel>> categoryList = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> categoryIncomeList = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> categoryExpenseList = ValueNotifier([]);

class CategoryDbFunctionsImpl extends CategoryDbFunctions {
  @override
  Future<void> getCategoryList() async {
    /*categoryList.value.clear();*/

    categoryIncomeList.value.clear();
    categoryExpenseList.value.clear();

    List<Map> list = await categoryDb.rawQuery('SELECT * FROM $categoryTable');

    list.forEach(
      (item) {
        CategoryModel categoryModel = CategoryModel(
          id: item['id'],
          name: item['name'],
          type: item['type'],
          isAvailable: item['isAvailable'],
        );

        /*categoryList.value.add(categoryModel);*/

        if (item['isAvailable'] == 1) {
          if (item['type'] == 1) {
            categoryIncomeList.value.add(categoryModel);
          } else {
            categoryExpenseList.value.add(categoryModel);
          }
        }
      },
    );
    categoryIncomeList.notifyListeners();
    categoryExpenseList.notifyListeners();

  }

  @override
  Future<void> addToCategory(CategoryModel categoryModel) async {
    await categoryDb.rawInsert(
        'INSERT INTO $categoryTable(name, isAvailable, type) VALUES(?, ?, ?)',
        [categoryModel.name, categoryModel.isAvailable, categoryModel.type]);

    getCategoryList();
  }
}

Future<void> deleteCategory(int id) async {


   await categoryDb.rawUpdate(
      'UPDATE $categoryTable SET isAvailable = ? WHERE id = ?', [0, id]);

  CategoryDbFunctionsImpl().getCategoryList();
}
