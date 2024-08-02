import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/isar/schemas/category.dart';
import '../../../../data/category/local_category_datasource.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final LocalCategoryDataSource localCategoryDataSource;
  CategoryBloc(this.localCategoryDataSource) : super(CategoryState(data: const [])) {
    on<CreateCategoryEvent>(_create);
    on<GetCategoriesEvent>(_getList);
  }

  void _create(CreateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final data = await localCategoryDataSource.addCategories(event.category);
    emit(state.copyWith(createError: !data, isLoading: false));
  }

  void _getList(GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final data = await localCategoryDataSource.getCategories();
    emit(state.copyWith(createError: data.isEmpty, isLoading: false, data: data));
  }
}
