import 'package:flutter/material.dart';
import 'package:money_management/db/transaction_db.dart';
import 'package:money_management/screens/category/Category.dart';
import 'package:money_management/screens/diaglog/add_category_dialog.dart';
import 'package:money_management/screens/transaction/add_transaction.dart';
import 'package:money_management/screens/transaction/transaction.dart';
import 'package:money_management/utils/global_variables.dart';
import 'package:money_management/widgets/money_bottom_navigation.dart';

import 'db/category_db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb().initTransactionDb();
    CategoryDb().initCategoryDb();


    return   MaterialApp(
      home:const Home(),
      initialRoute: 'home',
      routes: {
        'home': (context) => const Home(),
         '/AddTransaction': (context) =>   AddTransaction(),
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  static ValueNotifier<int> selectedBottomNavPosition = ValueNotifier(0);
  final _bottomNavPages = const [Transaction(), Category()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("MONEY MANAGER"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: selectedBottomNavPosition,
          builder: (context, pageIndex, widget) {
            return _bottomNavPages[pageIndex];
          }),
      bottomNavigationBar: const MoneyBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedBottomNavPosition.value == 0) {
            Navigator.pushNamed(context, '/AddTransaction');
          } else {
            Dialogs().addCategoryDialog(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
