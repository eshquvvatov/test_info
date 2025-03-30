
import 'package:aros_staff/core/utils/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_reset_otp_usecase.dart';
import '../../../domain/usecases/request_reset_otp_usecase.dart';

part 'sms_verification_event.dart';
part 'sms_verification_state.dart';

class SmsVerificationBloc extends Bloc<SmsVerificationEvent, SmsVerificationState> {
  final ResetCheckOtpUseCase _resetCheckOtpUseCase;
  final  ResetOtpUseCase _resetOtpUseCase;

  SmsVerificationBloc({required ResetCheckOtpUseCase resetCheckOtpUseCase,required ResetOtpUseCase resetOtpUseCase,required String phone})
      :_resetOtpUseCase=resetOtpUseCase ,_resetCheckOtpUseCase=resetCheckOtpUseCase,
        super(SmsVerificationState(message: "",pageState: SmsVerificationPageState.init, buttonIsActive: false, phoneNumber: phone, smsCode: '',codeStatus: SmsCodeStatus.init)) {
    on<SmsCodeInputEvent>(_inputCode);
    on<SendCodeEvent>(_sendCode);
    on<SmsSendEvent>(_validationSmsCode);
    on<TimeOutEvent>(_timeOut);
  }

  void _inputCode(SmsCodeInputEvent event,Emitter<SmsVerificationState> emit){
    if (event.smsCode.length ==4){
      emit(state.copyWith(smsCode: event.smsCode,buttonIsActive: true));
    }
    else{
      emit(state.copyWith(smsCode: event.smsCode,buttonIsActive: false));
    }

  }

  void _sendCode(SendCodeEvent event,Emitter<SmsVerificationState> emit)async{
    emit(state.copyWith(pageState: SmsVerificationPageState.loading));
    var response = await _resetOtpUseCase(params:ResetOtpParams(phone: state.phoneNumber, autofillCode: "") );
    response.fold(
            (left){ CustomToast.fireToast("${left.message}");  emit(state.copyWith(pageState: SmsVerificationPageState.error,message: left.message));},
            (right){ CustomToast.fireToast(right.message);  emit(state.copyWith(pageState: SmsVerificationPageState.success,message: right.message));});
  }

  void _timeOut(TimeOutEvent event,Emitter<SmsVerificationState> emit){
    emit(state.copyWith(buttonIsActive: event.isButtonActive));
  }

  void _validationSmsCode(SmsSendEvent event,Emitter<SmsVerificationState> emit)async{
    emit(state.copyWith(pageState: SmsVerificationPageState.loading));
    var response = await _resetCheckOtpUseCase(params:ResetCheckOtpParams(phone: state.phoneNumber, code: int.parse(state.smsCode)) );
    response.fold(
            (left){CustomToast.fireToast("${left.message}"); emit(state.copyWith(codeStatus: SmsCodeStatus.error,pageState: SmsVerificationPageState.error,message: left.message));},
            (right){CustomToast.fireToast(right.message); emit(state.copyWith(codeStatus: SmsCodeStatus.success,pageState: SmsVerificationPageState.success,message: right.message));});
  }
}
