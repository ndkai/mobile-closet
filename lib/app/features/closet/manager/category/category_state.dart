part of 'category_bloc.dart';

class CategoryState {
  bool isLoading;
  List<Category> data;
  bool? createError;
  bool? updateError;
  bool? getListError;
  bool? getError;

  CategoryState({
    this.isLoading = false,
    required this.data,
    this.createError = false ,
    this.updateError = false ,
    this.getListError = false,
    this.getError = false,
  });

  CategoryState copyWith({
    bool? isLoading,
    List<Category>? data,
    String? error,
    bool? createError,
    bool? updateError,
    bool? getListError,
    bool? getError,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      createError: createError ?? this.createError,
      updateError: updateError ?? this.updateError,
      getListError: getListError ?? this.getListError,
      getError: getError ?? this.getError,
    );
  }
}
