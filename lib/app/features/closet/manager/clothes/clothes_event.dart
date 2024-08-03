part of 'clothes_bloc.dart';

@immutable
sealed class ClothesEvent {}

class GetClothesEvent extends ClothesEvent {
  final int id;

  GetClothesEvent(this.id);
}

class GetClothesListEvent extends ClothesEvent {}

class UpdateClothesEvent extends ClothesEvent {
  final Clothes clothes;

  UpdateClothesEvent(this.clothes);
}

class CreateClothesEvent extends ClothesEvent {
  final Clothes clothes;

  CreateClothesEvent(this.clothes);
}

class DeleteClothesEvent extends ClothesEvent {
  final int id;

  DeleteClothesEvent(this.id);
}
