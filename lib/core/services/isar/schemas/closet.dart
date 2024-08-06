import 'package:isar/isar.dart';


part 'closet.g.dart';

@collection
class Closet {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? name;
  String? description;
  List<int>? categories;
  String? dateCreated;
  String? dateUpdated;
}
