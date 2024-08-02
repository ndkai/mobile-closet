import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleCubit extends Cubit<bool> {
  ToggleCubit() : super(false);

  void toggle() => emit(!state);
  void trigger() => emit(state);
  void set(bool value) => emit(value);
}

class SecondToggleCubit extends Cubit<bool> {
  var value = false;
  SecondToggleCubit() : super(false);

  void toggle() => emit(!state);


  void set(bool value){
    emit(value);
  }

  bool validate(){
    emit(state);
    return state;
  }
}

class ThirdToggleCubit extends Cubit<bool> {
  ThirdToggleCubit() : super(false);

  void toggle() => emit(!state);

  void set(bool value) => emit(value);
}

