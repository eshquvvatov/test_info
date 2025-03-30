import 'dart:async';
import 'package:aros_staff/core/utils/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/support_entity.dart';
import '../../domain/usecases/get_support_usecase.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final GetSupportInfo getSupportInfo;

  SettingBloc(this.getSupportInfo) : super(SettingState(supportInfo: null)) {
    on<FetchSupportInfo>(_onFetchSupportInfo);
  }

  Future<void> _onFetchSupportInfo(FetchSupportInfo event, Emitter<SettingState> emit) async {

    final result = await getSupportInfo();

    result.fold(
          (failure) => CustomToast.fireToast("${failure.message}"),
          (supportInfo) => emit(SettingState(supportInfo: supportInfo)),
    );
  }
}
