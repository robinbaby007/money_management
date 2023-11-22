import '../models/category_model.dart';
import '../utils/const.dart';
import '../utils/global_variables.dart';

abstract class CategoryDbFunctions {
  Future<void> getCategoryList();

  Future<void> addToCategory(CategoryModel categoryModel);

  Future<void> deleteCategory(int id);
}

class CategoryDbFunctionsImpl extends CategoryDbFunctions {
  @override
  Future<void> getCategoryList() async {
    categoryIncomeList.value.clear();
    categoryExpenseList.value.clear();

    List<Map> list = await categoryDb.rawQuery('SELECT * FROM $categoryTable');

    for (var item in list) {
      CategoryModel categoryModel = CategoryModel(
        id: item['id'],
        name: item['name'],
        type: item['type'],
        isAvailable: item['isAvailable'],
      );

      if (item['isAvailable'] == 1) {
        if (item['type'] == 1) {
          categoryIncomeList.value.add(categoryModel);
        } else {
          categoryExpenseList.value.add(categoryModel);
        }
      }
    }
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

  @override
  Future<void> deleteCategory(int id) async {
    await categoryDb.rawUpdate(
        'UPDATE $categoryTable SET isAvailable = ? WHERE id = ?', [0, id]);
    getCategoryList();
  }
}
