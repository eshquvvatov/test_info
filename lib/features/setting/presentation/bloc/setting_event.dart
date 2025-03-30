part of 'setting_bloc.dart';


abstract class SettingEvent {}




class FetchSupportInfo extends SettingEvent {}
class ToggleThemeMode extends SettingEvent {
  final bool isDark;
  ToggleThemeMode(this.isDark);
}