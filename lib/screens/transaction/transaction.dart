import 'package:flutter/material.dart';

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
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getMothFromDateString(transactionList[position].date),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        Text(
                          getDayFromDateString(transactionList[position].date),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ),
                  title: Text("Rs. ${transactionList[position].amount}/-"),
                  subtitle: Text(transactionList[position].expenseType == 0
                      ? "Expense"
                      : "Income"),
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
