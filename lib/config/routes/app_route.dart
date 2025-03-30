
import 'package:aros_staff/config/routes/router_names.dart';
import 'package:aros_staff/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:aros_staff/features/setting/domain/entities/support_entity.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/service_locator.dart';
import '../../features/auth/presentation/new_password/new_password_screen.dart';
import '../../features/auth/presentation/phone_number/phone_number.dart';
import '../../features/auth/presentation/signIn_screen/sign_in_screen.dart';
import '../../features/auth/presentation/sms_verification/sms_verification.dart';
import '../../features/home/presentation/main/main_screen.dart';
import '../../features/setting/presentation/pages/language_screen.dart';
import '../../features/setting/presentation/pages/support_screen.dart';
class AppRouter {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutesName.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutesName.main,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AppRoutesName.smsVerification,
        builder: (context, state) =>  SmsVerificationScreen(phone:state.extra as String),
      ),
      GoRoute(
        path: AppRoutesName.changePhoneNumber,
        builder: (context, state) => const PhoneNumberScreen(),
      ),
      GoRoute(
        path: AppRoutesName.newPassword,
        builder: (context, state) {
          final List<String> data = state.extra as List<String>;
          return NewPasswordScreen(phone: data[0], smsCode: data[1]);
        },
      ),
      GoRoute(
        path: AppRoutesName.language,
        builder: (context, state) => const LanguageScreen(),
      ),

      GoRoute(
        path: AppRoutesName.support,
        builder: (context, state) =>  Support(data: state.extra as SupportEntity?,),
      ),


    ],
    redirect: (context, state) {
      var otpInfo = sl<AuthUserLocalDataSource>().getOtpToken();

      print(state.matchedLocation);
      print(otpInfo.toString());
      final authPaths = [
        AppRoutesName.signIn,
        AppRoutesName.smsVerification,
        AppRoutesName.changePhoneNumber,
        AppRoutesName.newPassword,
      ];

      if (otpInfo == null) {
        if (!authPaths.contains(state.matchedLocation)) {

          return AppRoutesName.signIn;
        }

        return null;
      }
      else{
        if (state.matchedLocation == AppRoutesName.signIn){
          return AppRoutesName.main;
        }
        else{
          return null;
        }
      }


    },
  );
}