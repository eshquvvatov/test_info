
import 'package:aros_staff/core/constants/app_colors.dart';

import 'package:aros_staff/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:aros_staff/features/auth/presentation/widgets/password_input.dart';
import 'package:aros_staff/features/auth/presentation/widgets/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/router_names.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../widgets/custom_loader.dart';
import '../widgets/form_validator.dart';
import 'bloc/new_password_bloc.dart';


class NewPasswordScreen extends StatefulWidget {
  final String phone;
  final String smsCode;
  const NewPasswordScreen({super.key,required this.phone,required this.smsCode});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {



  final _formKey = GlobalKey<FormState>();

  void _validateAndSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<NewPasswordBloc>().add(PasswordAndPhoneValidationEvent(validate: true));
    } else {
      context.read<NewPasswordBloc>().add(PasswordAndPhoneValidationEvent(validate: false));
    }
  }


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>NewPasswordBloc(signInUseCase: sl<ResetNewPasswordUseCase>(), phone: widget.phone, smsCode: widget.smsCode),
      child: Scaffold(
        backgroundColor: AppColors.signInMainColor,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<NewPasswordBloc, NewPasswordState>(
          listener: (context,state){
            if(state.pageState == NewPasswordPageState.success){
              context.go(AppRoutesName.signIn);
            }
            if(state.pageState == NewPasswordPageState.error || state.pageState == NewPasswordPageState.success){
              ScaffoldMessenger.of(context,).showSnackBar( SnackBar(content: Text('${state.message}')));

            }
          },
          buildWhen: (previous, current) {
            return previous.pageState != current.pageState ;
          },
          builder: (context, state) {

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
                        Text("Enter new password", style: AppTextStyle.signInLargeTextStyle),
                        SizedBox(height: 10.h),
                        SizedBox(width: 190.w,child: Text("Enter a new password that you have come up with", textAlign: TextAlign.center,style: TextStyle(fontSize: 12.sp,color: Colors.white70))),
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
                      return Form(
                        key: _formKey,
                        child: Container(
                          height: 440.h + (keyboardHeight > 0 ? keyboardHeight/2 : 0),
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.all(16),
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: AppColors.signInCard,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
                          ),
                          child: BlocBuilder<NewPasswordBloc, NewPasswordState>(
                            buildWhen: (previous, current) {
                              return previous.buttonIsActive != current.buttonIsActive ;
                            },
                            builder: (context, state) {

                              return Padding(
                                padding:  EdgeInsets.only(bottom: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: CustomPhoneInput(onChange: (String phone){context.read<NewPasswordBloc>().add(PhoneInputEvent(phoneNumber: phone)); _validateAndSubmit(context);}, validator: Validators.phoneValidator),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: CustomPasswordInput(onChange: (String password){context.read<NewPasswordBloc>().add(PasswordInputEvent(password: password));_validateAndSubmit(context);}, validator: Validators.passwordValidator),
                                    ),
                                    Spacer(),
                                    CustomButton(isActive: state.buttonIsActive, onTap: (){context.read<NewPasswordBloc>().add( SubmitResetPasswordEvent());},),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  ),
                ),
                if(state.pageState == NewPasswordPageState.loading)
                  const CustomLoader()
              ],
            );
          },
        ),
      ),
    );
  }
}


