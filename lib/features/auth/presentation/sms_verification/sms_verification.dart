
import 'package:aros_staff/core/constants/app_colors.dart';
import 'package:aros_staff/core/extensions/phone_extension.dart';
import 'package:aros_staff/features/auth/domain/usecases/request_reset_otp_usecase.dart';
import 'package:aros_staff/features/auth/presentation/sms_verification/widgets/change_number_button.dart';
import 'package:aros_staff/features/auth/presentation/sms_verification/widgets/custom_sms_input.dart';
import 'package:aros_staff/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/router_names.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/check_reset_otp_usecase.dart';
import '../widgets/custom_loader.dart';
import 'bloc/sms_verification_bloc.dart';


class SmsVerificationScreen extends StatefulWidget {
  final String phone;
  const SmsVerificationScreen({super.key,required this.phone});

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SmsVerificationBloc(resetCheckOtpUseCase: sl<ResetCheckOtpUseCase>(),resetOtpUseCase: sl<ResetOtpUseCase>(), phone: widget.phone),
      child: Scaffold(
        backgroundColor: AppColors.signInMainColor,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<SmsVerificationBloc, SmsVerificationState>(
          listener: (context, state) {
            if(state.codeStatus ==SmsCodeStatus.success){
              context.pushReplacement(AppRoutesName.newPassword,extra: [state.phoneNumber,state.smsCode]);
            }

          },
          buildWhen: (previous, current) {
            return previous.pageState != current.pageState ;
          },
          builder: (context, state) {
            final viewInsets = MediaQuery.of(context).viewInsets;
            final keyboardHeight = viewInsets.bottom;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 76.h,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Enter verification code ", style: AppTextStyle.signInLargeTextStyle),
                        SizedBox(height: 10.h),
                        Text("A verification code has been sent to your number", style: TextStyle(fontSize: 12.sp,color: Colors.white70)),
                        Text("${widget.phone} ".toMaskedPhone, style: TextStyle(fontSize: 12.sp,color: Colors.white70)),
                        SizedBox(height: 90.h),
                        ChangePhoneNumber(onTap: () { context.pop(); },)
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 440.h + (keyboardHeight > 0 ? keyboardHeight/2 : 0),
                    padding: const EdgeInsets.all(16),
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: AppColors.signInCard,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmsCodeInput(onTap: (String value){ context.read<SmsVerificationBloc>().add(SmsCodeInputEvent(smsCode: value));}),
                        BlocBuilder<SmsVerificationBloc, SmsVerificationState>(
                          buildWhen: (previous, current) {
                            return previous.buttonIsActive != current.buttonIsActive ;
                          },
                          builder: (context, state) {
                            return Padding(
                              padding:  const EdgeInsets.only(bottom: 16),
                              child: CustomButton(isActive: state.buttonIsActive, onTap: (){context.read<SmsVerificationBloc>().add(SmsSendEvent());},),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                if(state.pageState == SmsVerificationPageState.loading)
                  const CustomLoader()
              ],
            );
          },
        ),
      ),
    );
  }
}


