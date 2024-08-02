part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}
class GetCategoryEvent extends CategoryEvent{
  final int id;

  GetCategoryEvent(this.id);
}
class GetCategoriesEvent extends CategoryEvent{}
class UpdateCategoryEvent extends CategoryEvent{
  final Category category;

  UpdateCategoryEvent(this.category);
}
class CreateCategoryEvent extends CategoryEvent{
  final Category category;

  CreateCategoryEvent(this.category);
}

class DeleteCategoryEvent extends CategoryEvent{
  final int id;

  DeleteCategoryEvent(this.id);
}