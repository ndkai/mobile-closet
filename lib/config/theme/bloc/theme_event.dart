import 'package:clean_architechture/config/theme/theme.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent{
  final ThemeType type;

  ToggleThemeEvent(this.type);

  List<Object?> get props => [type];
}