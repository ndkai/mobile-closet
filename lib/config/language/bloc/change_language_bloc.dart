
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_language_event.dart';
part 'change_language_state.dart';

class ChangeLanguageBloc extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(ChangeLanguageInitial()) {
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  void _changeLanguage(ChangeLanguageEvent event, Emitter<ChangeLanguageState> emit) async {
    // var lang = switch(event.language){
    //   case:
    //     return "";
    //
    //   default:
    //     return "";
    // }
    emit(const ChangeLanguageSuccess());
  }
}
