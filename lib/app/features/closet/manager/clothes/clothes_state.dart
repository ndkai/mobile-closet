part of 'clothes_bloc.dart';

abstract class ClothesState {}

class ClothesInitState extends ClothesState {}

class ClothesLoadingState extends ClothesState {}

class ClothesErrorState extends ClothesState {
  final String msg;

  ClothesErrorState(this.msg);
}

class ClothesCreateSuccessState extends ClothesState {}

class ClothesGetSuccessState extends ClothesState {
  final List<Clothes> clothes;

  ClothesGetSuccessState(this.clothes);
}

class ClothesDeleteSuccessState extends ClothesState {}

class ClothesUpdateSuccessState extends ClothesState {}

