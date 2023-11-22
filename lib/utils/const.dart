import 'package:flutter/material.dart';

const String categoryTable = "Category";

// const List<Map<int, String>> _categoryMap = [{1:'Income', 0: 'Expense'}];
const List<DropdownMenuEntry> categoryDropList = [
  DropdownMenuEntry(value: 0, label: 'Expense'),
  DropdownMenuEntry(value: 1, label: 'Income'),

];
