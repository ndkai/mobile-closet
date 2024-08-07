import 'package:isar/isar.dart';

part 'clothes_details.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? name;
  String? type;
  List<int>? categories;
  List<String>? occasions;
  List<String>? seasons;
  String? color;
  List<String>? material;
  String? dateCreated = DateTime.now().toIso8601String();
  String? dateUpdated;
}
