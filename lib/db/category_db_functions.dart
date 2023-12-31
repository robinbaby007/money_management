import '../models/category_model.dart';
import '../utils/const.dart';
import '../utils/global_variables.dart';
import 'category_db.dart';

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
    categoryList.value.clear();
    List<Map> list = await CategoryDb.instance.getCategoryDb().rawQuery('SELECT * FROM $categoryTable');

    await Future.forEach(list, (item) {
      CategoryModel categoryModel = CategoryModel(
        id: item['id'],
        name: item['name'],
        type: item['type'],
        isAvailable: item['isAvailable'],
      );

      if (item['isAvailable'] == 1) {
        categoryList.value.add(categoryModel);

        if (item['type'] == 1) {
          categoryIncomeList.value.add(categoryModel);
        } else {
          categoryExpenseList.value.add(categoryModel);
        }
      }

    });

    categoryIncomeList.notifyListeners();
    categoryExpenseList.notifyListeners();
    categoryList.notifyListeners();

    /*for (var item in list) {
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
    categoryExpenseList.notifyListeners();*/
  }

  @override
  Future<void> addToCategory(CategoryModel categoryModel) async {
    await CategoryDb.instance.getCategoryDb().rawInsert(
        'INSERT INTO $categoryTable(name, isAvailable, type) VALUES(?, ?, ?)',
        [categoryModel.name, categoryModel.isAvailable, categoryModel.type]);
    getCategoryList();
  }

  @override
  Future<void> deleteCategory(int id) async {
    await CategoryDb.instance.getCategoryDb().rawUpdate(
        'UPDATE $categoryTable SET isAvailable = ? WHERE id = ?', [0, id]);
    getCategoryList();
  }


  CategoryDbFunctionsImpl._catConstructor();
  static final CategoryDbFunctionsImpl instance =
      CategoryDbFunctionsImpl._catConstructor();

  factory CategoryDbFunctionsImpl() {
    return instance;
  }
}
