import 'package:money_management/db/transaction_db_functions.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/const.dart';
import '../utils/global_variables.dart';

class TransactionDb  {

  TransactionDb._catDbConstructor();

  static final TransactionDb instance = TransactionDb._catDbConstructor();

  factory TransactionDb() {
    return instance;
  }

  late Database transactionDb;

  Database getTransactionDb() {
    return transactionDb;
  }

  Future<void> initTransactionDb() async {
    transactionDb = await openDatabase("transactionDb.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $transactionTable (id INTEGER PRIMARY KEY, purpose TEXT, amount INTEGER, date TEXT , expenseType INTEGER)');
    });

    TransactionDbFunctionsImpl.instance.getTransactionList();

  }




}
