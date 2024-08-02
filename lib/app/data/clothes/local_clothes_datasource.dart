import 'package:clean_architechture/core/services/isar/isar_service.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes.dart'; // Update the import
import 'package:isar/isar.dart';

abstract class LocalClothesDataSource {
  Future<List<Clothes>> getClothes();
  Future<Clothes?> getClothesById(int id);
  Future<bool> addClothes(Clothes clothes);
  Future<bool> deleteClothes(int id);
  Future<bool> updateClothes(Clothes clothes);
}

class LocalClothesDataSourceImpl implements LocalClothesDataSource {
  final LocalDbProvider database;

  LocalClothesDataSourceImpl(this.database);

  @override
  Future<bool> addClothes(Clothes clothes) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.clothes.put(clothes); // Insert the new clothes
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteClothes(int id) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.clothes.delete(id); // Delete the clothes
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Clothes>> getClothes() async {
    try {
      final clothesList = await database.isar.clothes.where().findAll();
      return clothesList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> updateClothes(Clothes clothes) async {
    try {
      final existingClothes = await database.isar.clothes.get(clothes.id);
      if (existingClothes != null) {
        await database.isar.writeTxn(() async {
          await database.isar.clothes.put(clothes); // Update the clothes
        });
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Clothes?> getClothesById(int id) async {
    try {
      final clothes = await database.isar.clothes.get(id);
      return clothes;
    } catch (e) {
      return null;
    }
  }
}
