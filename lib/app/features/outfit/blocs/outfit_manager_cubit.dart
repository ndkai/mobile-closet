import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../presentation/pages/outfit_creation_screen.dart';


class OutfitManagerCubit extends Cubit<List<OutfitManagerState>> {
  OutfitManagerCubit() : super([]);
  List<OutfitManagerState> items = [];

  void addItem(OutfitManagerState value){
    final updatedItems = List<OutfitManagerState>.from(items)..add(value);
    items = updatedItems;

    emit(updatedItems);
  }

  void removeItem(int value){
    final updatedItems = List<OutfitManagerState>.from(items)..removeWhere((element) => element.id == value);
    print("lololol# ${items.length}");
    items = updatedItems;
    emit(items);
  }
}

class CurrentOutfitCubit extends Cubit<int> {
  CurrentOutfitCubit() : super(0);
  int currentItem = -1;

  void addItem(int value){
    currentItem = value;
    emit(value);
  }

  void removeItem(int value){
    currentItem = -1;
    emit(currentItem);
  }
}

class OutfitManagerState{
  final GlobalKey<OutfitItemState> key;
  final OutfitItem item;
  final int id;

  OutfitManagerState(this.key, this.item, this.id);
}