part of "new_password_bloc.dart";





enum NewPasswordPageState { init, loading, success, error }

class NewPasswordState extends Equatable {
  final NewPasswordPageState pageState;
  final bool buttonIsActive;
  final String phoneNumber;
  final String smsCode;
  final String password;
  final String? message;

  const NewPasswordState({
    required this.pageState,
    required this.buttonIsActive,
    required this.phoneNumber,
    required this.password,
    required this.smsCode,
    this.message,
  });

  NewPasswordState copyWith({
    NewPasswordPageState? pageState,
    bool? buttonIsActive,
    String? phoneNumber,
    String? smsCode,
    String? password,
    String? message,
  }) {
    return NewPasswordState(
      smsCode: smsCode??this.smsCode,
      pageState: pageState ?? this.pageState,
      buttonIsActive: buttonIsActive ?? this.buttonIsActive,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [pageState, buttonIsActive, phoneNumber, password];
}

