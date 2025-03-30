part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class PhoneInputEvent extends SignInEvent{
  final String phoneNumber;
  PhoneInputEvent({required this.phoneNumber});
}

class PasswordInputEvent extends SignInEvent{
  final String password;
  PasswordInputEvent({required this.password});
}

class PasswordAndPhoneValidationEvent extends SignInEvent{
  final bool validate;
  PasswordAndPhoneValidationEvent({required this.validate});
}

class SubmitSignInEvent extends SignInEvent {}