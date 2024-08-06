import 'package:clean_architechture/core/services/isar/isar_service.dart';
import 'package:clean_architechture/core/services/isar/schemas/closet.dart'; // Update the import path to match your Closet schema
import 'package:isar/isar.dart';

abstract class LocalClosetDataSource {
  Future<List<Closet>> getClosets();

  Future<Closet?> getClosetById(int id);

  Future<List<Closet>?> getClosetByName(String name);

  Future<bool> addCloset(Closet closet);

  Future<bool> deleteCloset(int id);

  Future<bool> updateCloset(Closet closet);
}

class LocalClosetDataSourceImpl implements LocalClosetDataSource {
  final LocalDbProvider database;

  LocalClosetDataSourceImpl(this.database);

  @override
  Future<bool> addCloset(Closet closet) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.closets.put(closet); // Insert the new closet
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteCloset(int id) async {
    try {
      await database.isar.writeTxn(() async {
        await database.isar.closets.delete(id); // Delete the closet
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Closet>> getClosets() async {
    try {
      final closets = await database.isar.closets.where().findAll();
      return closets;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> updateCloset(Closet closet) async {
    try {
      final e = await database.isar.closets.get(closet.id);
      if (e != null) {
        await database.isar.writeTxn(() async {
          await database.isar.closets.put(closet); // Update the closet
        });
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Closet?> getClosetById(int id) async {
    try {
      final e = await database.isar.closets.get(id);
      return e;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Closet>?> getClosetByName(String name) async {
    try {
      final data = await database.isar.closets.filter().nameEqualTo(name).findAll();
      print("getClosetByName $data");
      return data.isEmpty ? null : data;
    } catch (e) {
      print("getClosetByName $e");
      return null;
    }
  }
}
