import 'package:money_management/utils/const.dart';

import '../models/transaction_model.dart';
import '../utils/global_variables.dart';

abstract class TransactionDbFunctions {
  Future<void> getTransactionList();

  Future<void> addToTransaction(TransactionModel transactionModel);

  Future<void> deleteTransaction(int id);
}

class TransactionDbFunctionsImpl extends TransactionDbFunctions {
  @override
  Future<void> addToTransaction(TransactionModel transactionModel) async {
    await transactionDb.rawInsert(
      'INSERT INTO $transactionTable(purpose, amount, date, expenseType) VALUES(?, ?, ?, ? )',
      [
        transactionModel.purpose,
        transactionModel.amount,
        transactionModel.date,
        transactionModel.expenseType
      ],
    );
    getTransactionList();
  }

  @override
  Future<void> deleteTransaction(int id) async {
   }

  @override
  Future<void> getTransactionList() async {
    transactionList.value.clear();
      List<Map> list =
        await transactionDb.rawQuery('SELECT * FROM $transactionTable');
    await Future.forEach(
      list,
      (item) {
        TransactionModel transactionModel = TransactionModel(
          id: item['id'],
          purpose: item['purpose'],
          amount: item['amount'],
          date: item['date'],
          expenseType: int.parse(item['expenseType']),
        );
        transactionList.value.add(transactionModel);
        transactionList.notifyListeners();
      },
    );
  }
}
