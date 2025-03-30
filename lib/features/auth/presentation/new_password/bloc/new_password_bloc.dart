
import 'package:aros_staff/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final ResetNewPasswordUseCase signInUseCase;

  NewPasswordBloc({required this.signInUseCase,required String phone,required String smsCode}) :
        super( NewPasswordState(pageState: NewPasswordPageState.init, buttonIsActive: false, phoneNumber: phone, password: '',smsCode: smsCode)) {
          on<PhoneInputEvent>(_inputPhone);
          on<PasswordInputEvent>(_inputPassword);
          on<PasswordAndPhoneValidationEvent>(_validation);
          on<SubmitResetPasswordEvent>(_submitResetPassword);
  }

  void _inputPhone(PhoneInputEvent event,Emitter<NewPasswordState> emit){
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _inputPassword(PasswordInputEvent event,Emitter<NewPasswordState> emit){
    emit(state.copyWith(password: event.password));
  }
  void _validation(PasswordAndPhoneValidationEvent event,Emitter<NewPasswordState> emit){
    emit(state.copyWith(buttonIsActive: event.validate));
  }

  Future<void> _submitResetPassword(SubmitResetPasswordEvent event, Emitter<NewPasswordState> emit) async {
    emit(state.copyWith(pageState: NewPasswordPageState.loading));

    final result = await signInUseCase(params: ResetNewPasswordParams(phone: state.phoneNumber, code: int.parse(state.smsCode.trim()), newPassword: state.password));
    result.fold(
          (failure) => emit(state.copyWith( pageState: NewPasswordPageState.error, message: failure.message )),

          (entity) => emit(state.copyWith( pageState: NewPasswordPageState.success, message: entity.message)),
    );
  }
}
