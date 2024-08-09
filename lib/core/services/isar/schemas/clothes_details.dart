import 'package:isar/isar.dart';

part 'clothes_details.g.dart';

@collection
class ClothesDetails {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  int? clothesId;
  String? name;
  String? type;
  String? brand;
  double? price;
  List<int>? categories;
  List<String>? occasions;
  List<String>? seasons;
  List<String>? colors;
  List<String>? material;
  String? dateCreated = DateTime.now().toIso8601String();
  String? dateUpdated;
}
