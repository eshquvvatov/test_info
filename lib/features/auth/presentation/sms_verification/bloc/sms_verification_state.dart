part of 'sms_verification_bloc.dart';


enum SmsVerificationPageState { init, loading, success, error }
enum SmsCodeStatus {init, error,success}

class SmsVerificationState extends Equatable {
  final SmsVerificationPageState pageState;
  final bool buttonIsActive;
  final String phoneNumber;
  final String smsCode;
  final SmsCodeStatus codeStatus;
  final String message;



  const SmsVerificationState({
   required this.pageState ,
   required this.buttonIsActive ,
   required this.phoneNumber,
   required this.smsCode,
   required this.codeStatus,
    required this.message
  });


  SmsVerificationState copyWith({
    SmsVerificationPageState? pageState,
    bool? buttonIsActive,
    String? phoneNumber,
    String? smsCode,
    SmsCodeStatus? codeStatus,
    String? message
  }) {
    return SmsVerificationState(
      pageState: pageState ?? this.pageState,
      buttonIsActive: buttonIsActive ?? this.buttonIsActive,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      smsCode: smsCode ?? this.smsCode,
      codeStatus: codeStatus?? this.codeStatus,
      message: message??this.message
    );
  }

  @override
  List<Object> get props => [pageState, buttonIsActive, phoneNumber, smsCode,codeStatus];
}

