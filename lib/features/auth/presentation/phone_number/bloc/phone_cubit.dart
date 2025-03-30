
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/request_reset_otp_usecase.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
 final  ResetOtpUseCase _resetOtpUseCase;
  PhoneCubit({required ResetOtpUseCase resetOtpUseCase}): _resetOtpUseCase= resetOtpUseCase, super(PhoneState(message: "",pageState: PhonePageState.init));


  void sendCode({required String phoneNumber})async{
    emit(PhoneState(pageState: PhonePageState.loading,message: ""));
   var response = await _resetOtpUseCase(params: ResetOtpParams(phone: phoneNumber, autofillCode: ""));
   response.fold(
           (left){ emit(PhoneState(pageState: PhonePageState.error,message: "${left.message}"));},
           (right){emit(PhoneState(pageState: PhonePageState.sendCode,message: right.message));}
   );
  }
}
