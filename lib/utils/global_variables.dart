import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/transaction_db_functions.dart';
import 'package:sqflite/sqflite.dart';

import '../db/category_db_functions.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';

ValueNotifier<List<CategoryModel>> categoryList = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> categoryIncomeList = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> categoryExpenseList = ValueNotifier([]);

ValueNotifier<List<CategoryModel>> categoryTempListForTransaction =
    ValueNotifier(categoryExpenseList.value);

// late Database categoryDb;
// late Database transactionDb;
/*late CategoryDbFunctionsImpl categoryDbFunctionsImpl;*/
// late TransactionDbFunctionsImpl transactionDbFunctionsImpl;

ValueNotifier<String?> radioCurrentValue = ValueNotifier("Income");

ValueNotifier<List<TransactionModel>> transactionList = ValueNotifier([]);

void showSnack(context, message) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String getMothFromDateString(String dateSting) {
  DateTime afterParse = DateFormat('dd-MM-yyyy').parse(dateSting);
  /*String afterFormat = DateFormat('yyyy-MM-dd').format(afterParse);*/

  int month = afterParse.month;
  int day = afterParse.day;

  String monthText = DateFormat('MMM').format(DateTime(0, month));

  return monthText;
}

String getDayFromDateString(String dateSting) {
  DateTime afterParse = DateFormat('dd-MM-yyyy').parse(dateSting);
  /*String afterFormat = DateFormat('yyyy-MM-dd').format(afterParse);*/

  int day = afterParse.day;

  return day.toString();
}

String getYearFromDateString(String dateSting) {
  DateTime afterParse = DateFormat('dd-MM-yyyy').parse(dateSting);
  /*String afterFormat = DateFormat('yyyy-MM-dd').format(afterParse);*/

  int year = afterParse.year;

  return year.toString();
}

String dateFormatToYyyyMmDd(String dateSting) {
  DateTime afterParse = DateFormat('dd-MM-yyyy').parse(dateSting);
  String afterFormat = DateFormat('yyyy-MM-dd').format(afterParse);
  return afterFormat.toString();
}



