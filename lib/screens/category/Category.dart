import 'package:flutter/material.dart';
import 'package:money_management/screens/category/tab_items/expense.dart';
import 'package:money_management/screens/category/tab_items/income.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  final tabs = const [
    Tab(text: "INCOME"),
    Tab(text: "EXPENSE"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: tabs,
            ),
            const Expanded(
              child: TabBarView(children: [Income(), Expense()]),
            )
          ],
        ));
  }
}
