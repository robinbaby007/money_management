
import 'package:flutter/material.dart';

import '../main.dart';

class MoneyBottomNavigation extends StatelessWidget {
  const MoneyBottomNavigation({super.key});


  @override
  Widget build(BuildContext context) {
     return ValueListenableBuilder(
        valueListenable: Home.selectedBottomNavPosition,
       builder: (context, position, widget){
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Transaction"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: "Category"),
            ],
            currentIndex: position,
            onTap: (pos) {
              Home.selectedBottomNavPosition.value = pos;
            },
          );
       },
     );
  }
}


