import 'package:flutter/material.dart';
import 'package:money_management/screens/category/Category.dart';
import 'package:money_management/screens/transaction/transaction.dart';
import 'package:money_management/widgets/money_bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static ValueNotifier<int> selectedPosition = ValueNotifier(0);

  final _bottomNavPages = const [Transaction(), Category()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text("MONEY MANAGER"),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
            valueListenable: selectedPosition,
            builder: (context, pageIndex, widget) {
              return _bottomNavPages[pageIndex];
            }),
        bottomNavigationBar: const MoneyBottomNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedPosition.value == 0) {
              print("Transaction");
            } else {
              print("Cat");
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
