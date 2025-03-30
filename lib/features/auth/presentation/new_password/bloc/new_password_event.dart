part of 'new_password_bloc.dart';

abstract class NewPasswordEvent {
  const NewPasswordEvent();
}

class PhoneInputEvent extends NewPasswordEvent{
  final String phoneNumber;
  PhoneInputEvent({required this.phoneNumber});
}

class PasswordInputEvent extends NewPasswordEvent{
  final String password;
  PasswordInputEvent({required this.password});
}

class PasswordAndPhoneValidationEvent extends NewPasswordEvent{
  final bool validate;
  PasswordAndPhoneValidationEvent({required this.validate});
}

class SubmitResetPasswordEvent extends NewPasswordEvent {}