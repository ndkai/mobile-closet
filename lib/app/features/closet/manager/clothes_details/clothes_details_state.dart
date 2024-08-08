part of 'clothes_details_bloc.dart';


abstract class ClothesDetailsState {}

class ClothesDetailsInitState extends ClothesDetailsState {}

class ClothesDetailsLoadingState extends ClothesDetailsState {}

class ClothesDetailsErrorState extends ClothesDetailsState {
  final String msg;

  ClothesDetailsErrorState(this.msg);
}

class ClothesDetailsCreateSuccessState extends ClothesDetailsState {}

class ClothesDetailsGetSuccessState extends ClothesDetailsState {
  final List<ClothesDetails> clothesDetails;

  ClothesDetailsGetSuccessState(this.clothesDetails);
}

class ClothesDetailsDeleteSuccessState extends ClothesDetailsState {}

class ClothesDetailsUpdateSuccessState extends ClothesDetailsState {}
