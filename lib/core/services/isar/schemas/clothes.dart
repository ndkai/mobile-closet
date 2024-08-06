import 'package:isar/isar.dart';

part 'clothes.g.dart';

@collection
class Clothes {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? name;
  String? filePath;
  String dateCreated = DateTime.now().toIso8601String();
  String? dateUpdated;
  String? description;
  List<int>? categories;
  List<int>? closetId;
  List<String>? categoriesName;

}
