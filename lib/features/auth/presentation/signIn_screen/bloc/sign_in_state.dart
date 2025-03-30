part of 'sign_in_bloc.dart';


enum SignInPageState { init, loading, success, error }

class SignInState extends Equatable {
  final SignInPageState pageState;
  final bool buttonIsActive;
  final String phoneNumber;
  final String password;
  final String? message;

  const SignInState({
    required this.pageState,
    required this.buttonIsActive,
    required this.phoneNumber,
    required this.password,
    this.message,
  });

  SignInState copyWith({
    SignInPageState? pageState,
    bool? buttonIsActive,
    String? phoneNumber,
    String? password,
    String? message,
  }) {
    return SignInState(
      pageState: pageState ?? this.pageState,
      buttonIsActive: buttonIsActive ?? this.buttonIsActive,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      message: message,
    );
  }

  @override
  List<Object> get props => [pageState, buttonIsActive, phoneNumber, password];
}

