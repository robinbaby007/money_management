import 'package:flutter/material.dart';

import '../../db/category_db_functions.dart';
import '../../models/category_model.dart';
import '../../utils/const.dart';

class Dialogs extends CategoryDbFunctionsImpl {
  Future<void> addCategoryDialog(BuildContext context) {
    int categoryType = 0;

    TextEditingController _controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
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
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Name"),
                  ),
                  const SizedBox(height: 10),
                  DropdownMenu(
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
                      name: _controller.text,
                      type: categoryType,
                      isAvailable: 1);
                  addToCategory(newCategory);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
