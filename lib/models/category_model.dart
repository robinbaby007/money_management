
class CategoryModel {
  final int id;
  final String name;
  final int isAvailable; //1 available 0 deleted
  final int type; // 1 income 0 expense

  CategoryModel({this.id = -1, required this.name, required this.type, this.isAvailable = 1});
}
