
import 'package:aros_staff/config/routes/router_names.dart';
import 'package:aros_staff/core/constants/app_colors.dart';
import 'package:aros_staff/features/auth/domain/usecases/request_reset_otp_usecase.dart';
import 'package:aros_staff/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:aros_staff/features/auth/presentation/widgets/phone_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_text_style.dart';
import '../../../../core/di/service_locator.dart';
import '../widgets/custom_loader.dart';
import '../widgets/form_validator.dart';
import 'bloc/phone_cubit.dart';



class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {





  final _formKey = GlobalKey<FormState>();

  void _validateAndSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {

      isButtonActive.value = true;
    } else {
      isButtonActive.value = false;
    }

  }

  String changePhoneNumber = "";

  final ValueNotifier<bool> isButtonActive = ValueNotifier(false);



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PhoneCubit(resetOtpUseCase: sl<ResetOtpUseCase>()),
      child: Scaffold(
      backgroundColor: AppColors.signInMainColor,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<PhoneCubit, PhoneState>(
        listener: (context, state) {
          if (state.pageState == PhonePageState.sendCode){
            context.push(AppRoutesName.smsVerification,extra: changePhoneNumber);

          }
          else if (state.pageState == PhonePageState.sendCode || state.pageState == PhonePageState.error){
            ScaffoldMessenger.of(context,).showSnackBar( SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Positioned(
                  top: 76.h,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed:()=>context.pop(), icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
                            Text("New password", style: AppTextStyle.signInLargeTextStyle),
                            SizedBox(width: 48.w,)
                          ],
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(width: 190.w,child: Text("Enter your phone number again to enter a new password", textAlign: TextAlign.center,style: TextStyle(fontSize: 12.sp,color: Colors.white70))),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Builder(
                      builder: (context) {
                        final viewInsets = MediaQuery.of(context).viewInsets;
                        final keyboardHeight = viewInsets.bottom;
                        return Container(
                          height: 440.h + (keyboardHeight > 0 ? keyboardHeight/2 : 0),
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.all(16),
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: AppColors.signInCard,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
                          ),
                          child:  Padding(
                            padding:  const EdgeInsets.only(bottom: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: CustomPhoneInput(onChange: (String phone){changePhoneNumber = phone;_validateAndSubmit(context);}, validator:Validators.phoneValidator),
                                  ),
                                ),

                                ValueListenableBuilder<bool>(
                                  valueListenable: isButtonActive,
                                  builder: (context, isActive, child) {
                                    return CustomButton(
                                      isActive: isActive,
                                      onTap: () {
                                        if (isActive) {
                                          context.read<PhoneCubit>().sendCode(phoneNumber: changePhoneNumber);
                                        }
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
                if(state.pageState == PhonePageState.loading)
                  const CustomLoader()
              ],
            );
      },
      ),
    ),
   );
  }
}


