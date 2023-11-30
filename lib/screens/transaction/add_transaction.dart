import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:money_management/db/transaction_db_functions.dart';
import 'package:money_management/models/transaction_model.dart';

import '../../utils/const.dart';
import '../../utils/global_variables.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatelessWidget {
  AddTransaction({super.key});

  DateTime initialDate = DateTime.now();
  ValueNotifier finalDate = ValueNotifier("Select Date");

  TextEditingController purposeTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();
  int transactionCategory = -1;

  ValueNotifier selectedRadio = ValueNotifier(0);



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ADD TRANSACTION"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: purposeTextEditingController,
                decoration: const InputDecoration(hintText: "Purpose"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Amount"),
                controller: amountTextEditingController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    finalDate.value =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    initialDate = pickedDate;
                  }
                },
                child: Column(children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.blue),
                      const SizedBox(width: 4),
                      ValueListenableBuilder(
                        valueListenable: finalDate,
                        builder: (context, newDate, widget) {
                          return Text(finalDate.value);
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder(
                    builder: (context,value,widget){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio<int>(
                                value: categoryDropList[0].value,
                                groupValue:selectedRadio.value ,
                                onChanged: (value) {
                                  selectedRadio.value = value;
                                  categoryTempListForTransaction.value=categoryExpenseList.value;
                                },
                              ),
                              const Text("Expense")
                            ],
                          ),
                          Row(
                            children: [
                              Radio<int>(
                                value: categoryDropList[1].value,
                                groupValue: selectedRadio.value,
                                onChanged: (value) {
                                  selectedRadio.value = value;
                                  categoryTempListForTransaction.value=categoryIncomeList.value;
                                },
                              ),
                              const Text("Income")
                            ],
                          ),
                        ],
                      );
                    },
                    valueListenable: selectedRadio,
                   ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  )
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: categoryTempListForTransaction,
                builder: (context, list, widget) {
                  return DropdownMenu(
                    hintText: "Choose Transaction Category",
                    width: MediaQuery.of(context).size.width * .90,
                    dropdownMenuEntries: list
                        .map(
                          (e) => DropdownMenuEntry<int>(
                              value: e.type, label: e.name),
                        )
                        .toList(),
                    onSelected: (category) {
                      transactionCategory = category ?? -1;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (purposeTextEditingController.text.isEmpty) {
                      showSnack(context, "Enter Purpose");
                    } else if (amountTextEditingController.text.isEmpty) {
                      showSnack(context, "Enter Amount");
                    } else if (finalDate.value
                        .toString()
                        .trim()
                        .contains("Select Date")) {
                      showSnack(context, "Select a date");
                    } else if (transactionCategory == -1) {
                      showSnack(context, "Select Category Type");
                    } else {
                      TransactionModel model = TransactionModel(
                        amount: int.parse(amountTextEditingController.text),
                        date: finalDate.value,
                        expenseType: transactionCategory,
                        purpose: purposeTextEditingController.text,
                      );
                      await TransactionDbFunctionsImpl.instance.addToTransaction(model);
                      Navigator.of(context).pop();
                      showSnack(context, "Transaction Added Successfully");
                    }
                  },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
