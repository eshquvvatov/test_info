import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../bloc/sms_verification_bloc.dart';

typedef OnPinPut = void Function(String code);

class SmsCodeInput extends StatefulWidget {
  final OnPinPut onTap;
  const SmsCodeInput({super.key, required this.onTap});

  @override
  State<SmsCodeInput> createState() => _SmsCodeInputState();
}

class _SmsCodeInputState extends State<SmsCodeInput> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _canResend = false;
  bool _hasError = false; 
  int _remainingSeconds = 180;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
        context.read<SmsVerificationBloc>().add(TimeOutEvent(isButtonActive: false));
      }
    });
  }

  void _resendCode() {
    if (!_canResend) return;
    context.read<SmsVerificationBloc>().add(SendCodeEvent());
    setState(() {
      _canResend = false;
      _remainingSeconds = 180;
      _hasError = false;
      _pinController.clear();
      _startTimer();
    });


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Yangi kod yuborildi')),
    );
  }

  void _submitCode(String code,BuildContext context) {
    widget.onTap(code);
      }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: _hasError ? Colors.red : Colors.black, 
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: _hasError ? Colors.red : Colors.grey, 
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: _hasError ? Colors.red.withOpacity(0.1) : Colors.transparent, 
      ),
    );

    return BlocListener<SmsVerificationBloc, SmsVerificationState>(
          listener: (context, state) {
            if(state.codeStatus == SmsCodeStatus.error){
              setState(() => _hasError = true);
            }
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  length: 4,
                  controller: _pinController,
                  focusNode: _focusNode,
                  defaultPinTheme: defaultPinTheme,
                  showCursor: true,
                  onChanged: (var value){_submitCode(value,context);},
                  separatorBuilder: (index) => SizedBox(width: 10.w),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(
                        color: _hasError ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.red.withOpacity(0.1),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                SizedBox(height: 20.h),

                TextButton(
                  onPressed: _canResend ? _resendCode : null,
                  child: Text(
                    _canResend
                        ? 'Kodni qayta yuborish'
                        : 'Qayta yuborish ($_remainingSeconds)',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: _canResend ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
);
  }
}