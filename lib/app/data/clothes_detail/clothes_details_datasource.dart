import 'package:isar/isar.dart';
import '../../../core/services/isar/isar_service.dart';
import '../../../core/services/isar/schemas/clothes_details.dart';

abstract class LocalClothesDetailsDataSource {
  Future<List<ClothesDetails>> getClothesDetails();
  Future<ClothesDetails?> getClothesDetailsById(int id);
  Future<bool> addClothesDetails(ClothesDetails clothesDetails);
  Future<bool> deleteClothesDetails(int id);
  Future<bool> updateClothesDetails(ClothesDetails clothesDetails);
}

class LocalClothesDetailsDataSourceImpl implements LocalClothesDetailsDataSource {
  final LocalDbProvider database;

  LocalClothesDetailsDataSourceImpl(this.database);

  @override
  Future<bool> addClothesDetails(ClothesDetails clothesDetails) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.clothesDetails.put(clothesDetails); // Insert the new clothesDetails
      });

      return true;
    } catch (e) {

      return false;
    }
  }

  @override
  Future<bool> deleteClothesDetails(int id) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.clothesDetails.delete(id); // Delete the clothesDetails
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ClothesDetails>> getClothesDetails() async {
    try {
      final clothesDetailsList = await database.isar.clothesDetails.where().findAll();
      return clothesDetailsList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> updateClothesDetails(ClothesDetails clothesDetails) async {
    try {
      // final existingClothesDetails = await database.isar.clothesDetails.get(clothesDetails.id);
      await database.isar.writeTxn(() async {
        await database.isar.clothesDetails.put(clothesDetails); // Update the clothesDetails
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ClothesDetails?> getClothesDetailsById(int id) async {
    try {
      final clothesDetails = await database.isar.clothesDetails.filter().clothesIdEqualTo(id).findAll();
      if(clothesDetails.isNotEmpty){
        return clothesDetails.first;
      }
      return null;
    } catch (e) {
      return null;
    }
  }


}
