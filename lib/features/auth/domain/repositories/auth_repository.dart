import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/auth/domain/entities/old_login_entity.dart';
import '../entities/reset_otp_entity.dart';
import '../entities/reset_otp_verify_entity.dart';
import '../entities/reset_password_entity.dart';

abstract class AuthRepository {


  Future<Either<Failure, OldLoginEntity>> oldLogin(String phone, String password, String? autofillCode);


  // ask reset otp
  Future<Either<Failure, ResetOtpEntity>> resetOtp(String phone, String autofillCode);
  
// ask virify check otp
  Future<Either<Failure, ResetOtpVerifyEntity>> resetCheckOtp(String phone, int code);
  
  // change new password
  Future<Either<Failure, ResetPasswordEntity>> resetNewPassword(String phone, int code, String newPassword);
}