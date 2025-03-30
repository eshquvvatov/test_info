
import 'package:aros_staff/core/extensions/phone_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/old_login_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final OldLoginUseCase signInUseCase;

  SignInBloc({required this.signInUseCase}) : super(const SignInState(pageState: SignInPageState.init, buttonIsActive: false, phoneNumber: '', password: '',)) {
    on<PhoneInputEvent>(_inputPhone);
    on<PasswordInputEvent>(_inputPassword);
    on<PasswordAndPhoneValidationEvent>(_validation);
    on<SubmitSignInEvent>(_submitSignIn);
  }

  void _inputPhone(PhoneInputEvent event,Emitter<SignInState> emit){

    emit(state.copyWith(phoneNumber: event.phoneNumber));

  }

  void _inputPassword(PasswordInputEvent event,Emitter<SignInState> emit){
    emit(state.copyWith(password: event.password));
  }
  void _validation(PasswordAndPhoneValidationEvent event,Emitter<SignInState> emit){
    emit(state.copyWith(buttonIsActive: event.validate));
  }

  Future<void> _submitSignIn(SubmitSignInEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(pageState: SignInPageState.loading));

    final result = await signInUseCase(params: OldLoginParams(phone: state.phoneNumber.toFormattedPhone, password: state.password, autofillCode: null)); // autofillCode ixtiyoriy
    result.fold(
          (failure) => emit(state.copyWith(
        pageState: SignInPageState.error,
        message: failure.message,
      )),
          (entity) => emit(state.copyWith(
        pageState: SignInPageState.success,
        message: entity.message,
      )),
    );
  }
}
