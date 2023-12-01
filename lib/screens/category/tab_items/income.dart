import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../db/category_db_functions.dart';
import '../../../utils/global_variables.dart';

class Income extends StatelessWidget {
  const Income({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, incomeList, widget) {
        if(incomeList.isNotEmpty){
          return ListView.separated(
              padding: const EdgeInsets.all(4),
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(incomeList[index].name),
                    trailing: GestureDetector(
                      onTap: () {
                        CategoryDbFunctionsImpl.instance.deleteCategory(incomeList[index].id);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              },
              itemCount: incomeList.length);
        }
        else{

          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "No Income",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue),
                ),
              ),
            ],
          );
        }
      },
      valueListenable: categoryIncomeList,
    );
  }
}
