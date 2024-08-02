part of 'category_bloc.dart';

abstract class CategoryState {}
class CategoryInitState extends CategoryState{}

class CategoryLoadingState extends CategoryState{}
class CategoryErrorState extends CategoryState{
  final String msg;

  CategoryErrorState(this.msg);
}
class CategoryCreateSuccessState extends CategoryState{}
class CategoryGetSuccessState extends CategoryState{
  final List<Category> categories;

  CategoryGetSuccessState(this.categories);
}
class CategoryDeleteSuccessState extends CategoryState{}
class CategoryUpdateSuccessState extends CategoryState{}