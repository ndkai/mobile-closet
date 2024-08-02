import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/isar/schemas/category.dart';
import '../../../../data/category/local_category_datasource.dart';

part 'category_event.dart';
part 'category_state.dart';

class CreateCategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final LocalCategoryDataSource localCategoryDataSource;
  CreateCategoryBloc(this.localCategoryDataSource) : super(CategoryInitState()) {
    on<CreateCategoryEvent>(_create);
  }

  void _create(CreateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final data = await localCategoryDataSource.addCategories(event.category);
    if(data){
      emit(CategoryCreateSuccessState());
    } else {
      emit(CategoryErrorState("Error"));
    }

  }
}

class UpdateCategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final LocalCategoryDataSource localCategoryDataSource;
  UpdateCategoryBloc(this.localCategoryDataSource) : super(CategoryInitState()) {
    on<CreateCategoryEvent>(_create);
  }

  void _create(CreateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final data = await localCategoryDataSource.updateCategories(event.category);
    if(data){
      emit(CategoryUpdateSuccessState());
    } else {
      emit(CategoryErrorState("Error"));
    }

  }
}

class DeleteCategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final LocalCategoryDataSource localCategoryDataSource;
  DeleteCategoryBloc(this.localCategoryDataSource) : super(CategoryInitState()) {
    on<DeleteCategoryEvent>(_create);
  }

  void _create(DeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final data = await localCategoryDataSource.deleteCategories(event.id);
    if(data){
      emit(CategoryDeleteSuccessState());
    } else {
      emit(CategoryErrorState("Error"));
    }

  }
}

class GetCategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final LocalCategoryDataSource localCategoryDataSource;
  GetCategoryBloc(this.localCategoryDataSource) : super(CategoryInitState()) {
    on<GetCategoriesEvent>(_create);
  }

  void _create(GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final data = await localCategoryDataSource.getCategories();
    if(data.isNotEmpty){
      emit(CategoryGetSuccessState(data));
    } else {
      emit(CategoryErrorState("Error"));
    }

  }
}