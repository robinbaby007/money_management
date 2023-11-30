import 'package:flutter/material.dart';

import '../../db/category_db_functions.dart';
import '../../models/category_model.dart';
import '../../utils/const.dart';

class Dialogs {
  Future<void> addCategoryDialog(BuildContext context) {
    int categoryType = 0;

    TextEditingController controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Add Category",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: "Name",
                      border: boarderProperty,
                      enabledBorder: boarderProperty),
                ),
                const SizedBox(height: 10),
                DropdownMenu(
                  inputDecorationTheme: const InputDecorationTheme(
                    enabledBorder: boarderProperty,
                  ),
                  hintText: "Choose Type",
                  width: MediaQuery.of(context).size.width * .60,
                  dropdownMenuEntries: [
                    categoryDropList[0],
                    categoryDropList[1]
                  ],
                  onSelected: (type) {
                    categoryType = type;
                  },
                ),
                /*const Row(
                  children: [
                    CustomRadio(title: "Income", type: "Income"),
                    CustomRadio(title: "Expense", type: "Expense"),
                  ],
                )*/
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                CategoryModel newCategory = CategoryModel(
                    name: controller.text, type: categoryType, isAvailable: 1);

                CategoryDbFunctionsImpl.instance.addToCategory(newCategory);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/*class CustomRadio extends StatelessWidget {
  final String type;
  final String title;

  const CustomRadio({required this.type, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: radioCurrentValue,
            builder: (context, value, widget) {
              return Radio(
                value: type,
                groupValue: radioCurrentValue.value,
                onChanged: (newValue) {
                  radioCurrentValue.value = newValue;
                  radioCurrentValue.notifyListeners();
                },
              );
            }),
        Text(title)
      ],
    );
  }
}*/
