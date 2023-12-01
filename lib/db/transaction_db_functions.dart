import 'package:money_management/db/transaction_db.dart';
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
    await TransactionDb.instance.getTransactionDb().rawInsert(
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
    await TransactionDb.instance
        .getTransactionDb()
        .rawUpdate('DELETE FROM $transactionTable WHERE id = ?', [id]);
  }

  @override
  Future<void> getTransactionList() async {
    transactionList.value.clear();

    totalIncome.value = 0;
    totalExpense.value =0;

    List<Map> list = await TransactionDb.instance
        .getTransactionDb()
        .rawQuery('SELECT * FROM $transactionTable');
    await Future.forEach(
      list,
      (item) {
        TransactionModel transactionModel = TransactionModel(
          id: item['id'],
          purpose: item['purpose'],
          amount: item['amount'],
          date: item['date'],
          expenseType: item['expenseType'],
        );
        transactionList.value.add(transactionModel);
        transactionList.value.sort(
          (pre, latest) => dateFormatToYyyyMmDd(pre.date).compareTo(
            dateFormatToYyyyMmDd(latest.date),
          ),
        );

        if (item['expenseType'] == 0) {
          var expense= item['amount'] as int;
          totalExpense.value = totalExpense.value + expense;
        } else {
          var income= item['amount'] as int;
          totalIncome.value = totalIncome.value + income;
        }

      },
    );
    balance.value= totalIncome.value-totalExpense.value;
    transactionList.notifyListeners();
    totalIncome.notifyListeners();
    totalExpense.notifyListeners();
    balance.notifyListeners();

  }

  TransactionDbFunctionsImpl._transConstructor();

  static final TransactionDbFunctionsImpl instance =
      TransactionDbFunctionsImpl._transConstructor();

  factory TransactionDbFunctionsImpl() {
    return instance;
  }
}
