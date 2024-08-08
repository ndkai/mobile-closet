part of 'clothes_details_bloc.dart';


@immutable
sealed class ClothesDetailsEvent {}

class GetClothesDetailsEvent extends ClothesDetailsEvent {
  final int id;

  GetClothesDetailsEvent(this.id);
}

class GetClothesDetailsListEvent extends ClothesDetailsEvent {}


class UpdateClothesDetailsEvent extends ClothesDetailsEvent {
  final ClothesDetails clothesDetails;

  UpdateClothesDetailsEvent(this.clothesDetails);
}

class CreateClothesDetailsEvent extends ClothesDetailsEvent {
  final ClothesDetails clothesDetails;

  CreateClothesDetailsEvent(this.clothesDetails);
}

class DeleteClothesDetailsEvent extends ClothesDetailsEvent {
  final int id;

  DeleteClothesDetailsEvent(this.id);
}
