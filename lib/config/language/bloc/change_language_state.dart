part of 'change_language_bloc.dart';

abstract class ChangeLanguageState extends Equatable {
  const ChangeLanguageState();
}

class ChangeLanguageInitial extends ChangeLanguageState {
  @override
  List<Object> get props => [];
}


class ChangeLanguageSuccess extends ChangeLanguageState {
  final String language;

  const ChangeLanguageSuccess({this.language = 'us'});
  @override
  List<Object> get props => [];
}

