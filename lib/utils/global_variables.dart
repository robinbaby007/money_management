

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../db/category_db_functions.dart';
import '../models/category_model.dart';

ValueNotifier<List<CategoryModel>> categoryList = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> categoryIncomeList = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> categoryExpenseList = ValueNotifier([]);

late Database categoryDb;

late CategoryDbFunctionsImpl categoryDbFunctionsImpl;