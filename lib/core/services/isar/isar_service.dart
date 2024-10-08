import 'package:clean_architechture/core/services/isar/schemas/category.dart';
import 'package:clean_architechture/core/services/isar/schemas/closet.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes_details.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDbProvider{
  late Isar isar;
  Future<LocalDbProvider> init() async {
    final dir = await getApplicationDocumentsDirectory();
    List<CollectionSchema<dynamic>> schemas= [
      ClothesSchema,
      CategorySchema,
      ClosetSchema,
      ClothesDetailsSchema,
    ];
    isar = await Isar.open(
      schemas,
      directory: dir.path,
    );
    return this;
  }

}