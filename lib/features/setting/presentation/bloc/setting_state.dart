part of 'setting_bloc.dart';


class SettingState extends Equatable {
  final SupportEntity? supportInfo;
  const SettingState({required this.supportInfo});

  @override
  List<Object?> get props => [supportInfo];
}