import 'package:bloc/bloc.dart';

class ChangeDataCubit extends Cubit<dynamic> {
  ChangeDataCubit() : super(null);

  void change(dynamic data) => emit(data);
}
