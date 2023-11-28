
class TransactionModel {
  final int id;
  final String purpose;
  final int amount; //1 available 0 deleted
  final String date;
  final int expenseType;// 1 income 0 expense

  TransactionModel({this.id = -1, required this.purpose, required this.amount, required this.date, required this.expenseType });
}
