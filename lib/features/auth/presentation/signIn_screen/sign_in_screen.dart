
import 'package:aros_staff/config/routes/router_names.dart';
import 'package:aros_staff/core/constants/app_colors.dart';
import 'package:aros_staff/features/auth/presentation/widgets/custom_check_box.dart';
import 'package:aros_staff/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:aros_staff/features/auth/presentation/widgets/password_input.dart';
import 'package:aros_staff/features/auth/presentation/widgets/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_text_style.dart';
import '../../../../core/di/service_locator.dart';
import '../widgets/custom_loader.dart';
import '../widgets/form_validator.dart';
import 'bloc/sign_in_bloc.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {



  final _formKey = GlobalKey<FormState>();

  void _validateAndSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(PasswordAndPhoneValidationEvent(validate: true));
    } else {
      context.read<SignInBloc>().add(PasswordAndPhoneValidationEvent(validate: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(signInUseCase: sl()),
       child: Scaffold(
          backgroundColor: AppColors.signInMainColor,
         resizeToAvoidBottomInset: false,
          body: BlocConsumer<SignInBloc, SignInState>(
             listener: (BuildContext context, SignInState state) {
               if (state.message != null){
                 ScaffoldMessenger.of(context,).showSnackBar( SnackBar(content: Text('${state.message}')));
               }
               if(state.pageState == SignInPageState.success){
                 context.go(AppRoutesName.main);
               }
             },
             buildWhen: (previous, current) {
              return previous.pageState != current.pageState ;
              },
            builder: (context, state) {
              final viewInsets = MediaQuery.of(context).viewInsets;
              final keyboardHeight = viewInsets.bottom;
              return Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Positioned(
                    bottom: 500.h,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Welcome to AROS!", style: AppTextStyle.signInLargeTextStyle),
                          SizedBox(height: 10.h),
                          Text("Please fill in your details below", style: AppTextStyle.signInSmallTextStyle),
                          SizedBox(height: 30.h),
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 26.h),
                            CustomPhoneInput(onChange: (value) {context.read<SignInBloc>().add(PhoneInputEvent(phoneNumber: value));_validateAndSubmit(context);}, validator: Validators.phoneValidator),
                            SizedBox(height: 16.h),
                            CustomPasswordInput(onChange: (value) {context.read<SignInBloc>().add(PasswordInputEvent(password: value)); _validateAndSubmit(context);}, validator:Validators.passwordValidator),
                            SizedBox(height: 26.h),

                            CustomCheckBox(onTap: (bool checked) {  },),
                            const Spacer(),
                            BlocBuilder<SignInBloc, SignInState>(
                              buildWhen: (previous, current) {
                                return previous.buttonIsActive != current.buttonIsActive ;
                              },
                              builder: (context, state) {
                                return CustomButton(isActive: state.buttonIsActive, onTap: () => context.read<SignInBloc>().add(SubmitSignInEvent()),);
                              },
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),
                  ),

                  if(state.pageState == SignInPageState.loading)
                    const CustomLoader()
                ],
              );
            }
    ),
        ),
);
  }
}


