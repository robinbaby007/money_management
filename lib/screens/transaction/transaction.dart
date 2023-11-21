import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(4),
        itemBuilder: (context, position) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: const ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Text(
                  "DEC\n 22",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text("Rs. 500/-"),
              subtitle: Text("Travel"),
            ),
          );
        },
        separatorBuilder: (context, position) {
          return const SizedBox(height: 4);
        },
        itemCount: 10);
  }
}
