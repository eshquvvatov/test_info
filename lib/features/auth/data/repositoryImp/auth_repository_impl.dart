import 'dart:convert';
import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/auth/domain/entities/old_login_entity.dart';
import 'package:aros_staff/features/auth/domain/entities/reset_otp_entity.dart';
import 'package:aros_staff/features/auth/domain/entities/reset_otp_verify_entity.dart';
import 'package:aros_staff/features/auth/domain/entities/reset_password_entity.dart';


import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local/auth_local_data_source.dart';
import '../data_sources/remote/auth_remote_data_source.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthUserLocalDataSource localDataSource;
  AuthRepositoryImpl({required this.remoteDataSource, required this.localDataSource});


  @override
  Future<Either<Failure, ResetOtpVerifyEntity>> resetCheckOtp( String phone, int code) async{
    try {
      var response = await remoteDataSource.resetCheckOtp(phone: phone,code:code );
      return FoldRight(response);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetNewPassword( String phone, int code, String newPassword) async{
    try {
      var response = await remoteDataSource.resetNewPassword(phone:phone ,code:code ,newPassword:newPassword );
      return FoldRight(response);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, ResetOtpEntity>> resetOtp( String phone, String autofillCode)  async{
    try {
      var response = await remoteDataSource.resetOtp(phone: phone, autofillCode: autofillCode);
      return FoldRight(response);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, OldLoginEntity>> oldLogin(String phone, String password, String? autofillCode) async{
    try {
      var response = await remoteDataSource.oldLogin(phone: phone, password: password,autofillCode: autofillCode);
      await localDataSource.storeToken(otpInfo:json.encode(response));
      return FoldRight(response);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }

  }




}
