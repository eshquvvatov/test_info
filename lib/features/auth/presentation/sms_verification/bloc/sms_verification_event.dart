part of 'sms_verification_bloc.dart';

abstract class SmsVerificationEvent {
  const SmsVerificationEvent();
}

class SmsCodeInputEvent extends SmsVerificationEvent{
  final String smsCode;
  SmsCodeInputEvent({required this.smsCode});
}

class SendCodeEvent extends SmsVerificationEvent{

  SendCodeEvent();
}

class SmsSendEvent extends SmsVerificationEvent{
  SmsSendEvent();
}
class TimeOutEvent extends SmsVerificationEvent{
  final bool isButtonActive;
  TimeOutEvent({required this.isButtonActive});
}
