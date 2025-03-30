

import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/extensions/phone_extension.dart';
import 'package:aros_staff/features/auth/data/model/old_login_model.dart';
import 'package:dio/dio.dart';
import '../../../../../core/constants/api.dart';
import '../../../../../core/network/api_client.dart';
import '../../model/reset_otp_model.dart';
import '../../model/reset_otp_verify_model.dart';
import '../../model/reset_passeord_model.dart';

abstract class AuthRemoteDataSource {


  Future<OldLoginModel> oldLogin({
    required String phone,
    required String password,
    String? autofillCode,
  });


  Future<ResetOtpModel> resetOtp({
    required String phone,
    required String autofillCode,
  });

  Future<ResetOtpVerifyModel> resetCheckOtp({
    required String phone,
    required int code,
  });

  Future<ResetPasswordModel> resetNewPassword({
    required String phone,
    required int code,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<OldLoginModel> oldLogin({required String phone, required String password, String? autofillCode}) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.oldLogin,
        data: {
          'phone': phone.toFormattedPhone,
          'password': password,
          'autofill_code': autofillCode,
        },
      );
      return OldLoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message: _handleDioError(e),statusCode: e.response?.statusCode);
    }
  }



  @override
  Future<ResetOtpModel> resetOtp({
    required String phone,
    required String autofillCode,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.resetWithOtp,
        data: {
          'phone': phone.toFormattedPhone,
          'autofill_code': autofillCode,
        },
      );
      return ResetOtpModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message: _handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<ResetOtpVerifyModel> resetCheckOtp({
    required String phone,
    required int code,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.checkResetOtp,

        data: {
          'phone': phone.toFormattedPhone,
          'code': code,
        },
      );
      return ResetOtpVerifyModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message: _handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<ResetPasswordModel> resetNewPassword({
    required String phone,
    required int code,
    required String newPassword,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.resetPassword,
        data: {
          'phone': phone.toFormattedPhone,
          'code': code,
          'password': newPassword,
        },
      );
      return ResetPasswordModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message: _handleDioError(e),statusCode: e.response?.statusCode);
    }
  }


  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Internetga ulanish vaqti tugadi. Iltimos, tarmoq aloqasini tekshiring.";
      case DioExceptionType.sendTimeout:
        return "So'rov yuborish vaqti tugadi. Qayta urinib ko'ring.";
      case DioExceptionType.receiveTimeout:
        return "Serverdan javob olish vaqti tugadi. Keyinroq urinib ko'ring.";
      case DioExceptionType.badResponse:
        if (e.response != null) {
          final statusCode = e.response!.statusCode;
          final message = e.response!.data['error'] ?? "Noma'lum xatolik";
          switch (statusCode) {
            case 400:
              return "Noto'g'ri so'rov 400: $message";
            case 401:
              return "Avtorizatsiya xatosi 401: $message";
            case 403:
              return "Ruxsat yo'q 403: $message";
            case 404:
              return "Ma'lumot topilmadi 404: $message";
            case 500:
              return "Server xatosi 500: $message";
            default:
              return "Xatolik: $statusCode - $message";
          }
        }
        return "Javobdagi xatolik: Noma'lum muammo";
      case DioExceptionType.cancel:
        return "So'rov bekor qilindi";
      case DioExceptionType.connectionError:
        return "Internet aloqasi yo'q. Iltimos, ulanishingizni tekshiring.";
      default:
        return "Kutilmagan xatolik: ${e.message ?? 'Tafsilotlar yo\'q'}";
    }
  }


}