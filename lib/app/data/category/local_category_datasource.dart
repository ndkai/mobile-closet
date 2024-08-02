import 'package:clean_architechture/core/services/isar/isar_service.dart';
import 'package:clean_architechture/core/services/isar/schemas/category.dart';
import 'package:isar/isar.dart';

abstract class LocalCategoryDataSource {
  Future<List<Category>> getCategories();
  Future<Category?> getCategoryById(int id);

  Future<bool> addCategories(Category category);

  Future<bool> deleteCategories(int id);

  Future<bool> updateCategories(Category category);
}

class LocalCategoryDataSourceImpl implements LocalCategoryDataSource {
  final LocalDbProvider database;

  LocalCategoryDataSourceImpl(this.database);

  @override
  Future<bool> addCategories(Category category) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.categorys.put(category); // Insert the new user
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteCategories(int id) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.categorys.delete(id); // Insert the new user
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final categories = await database.isar.categorys.where().findAll();
      return categories;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> updateCategories(Category category) async {
    try {
      final e = await database.isar.categorys.get(category.id);
      if(e != null){
        await database.isar.writeTxn(() async {
          await database.isar.categorys.put(category); // Update the user
        });
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Category?> getCategoryById(int id) async {
    try {
      final e = await database.isar.categorys.get(id);
      return  e;
    } catch (e) {
      return null;
    }
  }
}
