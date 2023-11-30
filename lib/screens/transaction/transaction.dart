import 'package:flutter/material.dart';

import '../../db/transaction_db_functions.dart';
import '../../utils/global_variables.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: transactionList,
      builder: (context, transactionList, widget) {
        return ListView.separated(
            padding: const EdgeInsets.all(4),
            itemBuilder: (context, position) {
              return Dismissible(
                key: Key(
                  transactionList[position].id.toString(),
                ),
                direction: DismissDirection.endToStart,
                background: const ColoredBox(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8)
                      ],
                    )),
                confirmDismiss: (_) async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Do you want to delete?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Yes'),
                          )
                        ],
                      );
                    },
                  );

                  return confirmed;
                },
                onDismissed: (direction) {
                   TransactionDbFunctionsImpl()
                      .deleteTransaction(transactionList[position].id);
                  TransactionDbFunctionsImpl().getTransactionList();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor:
                            transactionList[position].expenseType == 0
                                ? Colors.redAccent
                                : Colors.green,
                        radius: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getMothFromDateString(
                                  transactionList[position].date),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              getDayFromDateString(
                                  transactionList[position].date),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              getYearFromDateString(
                                  transactionList[position].date),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 10),
                            ),
                          ],
                        )),
                    title: Text("Rs. ${transactionList[position].amount}/-"),
                    subtitle: Text(transactionList[position].purpose),
                    trailing: Text(transactionList[position].expenseType == 0
                        ? "Expense"
                        : "Income"),
                  ),
                ),
              );
            },
            separatorBuilder: (context, position) {
              return const SizedBox(height: 4);
            },
            itemCount: transactionList.length);
      },
    );
  }
}
