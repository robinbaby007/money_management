import 'package:flutter/material.dart';
import 'package:money_management/db/category_db_functions.dart';

import '../../../utils/global_variables.dart';

class Expense extends StatelessWidget {
  const Expense({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, expenseList, widget) {
        return ListView.separated(
            padding: const EdgeInsets.all(4),
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(expenseList[index].name),
                  trailing: GestureDetector(
                    onTap: () {
                      categoryDbFunctionsImpl.deleteCategory(expenseList[index].id);
                    },
                    child: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 4);
            },
            itemCount: expenseList.length);
      },
      valueListenable: categoryExpenseList,
    );
  }
}
