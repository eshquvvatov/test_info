import 'package:aros_staff/core/error/failer.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/api_client.dart';
import '../../model/support_model.dart';


abstract class SupportRemoteDataSource {
  Future<SupportModel> getSupportInfo();
}

class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  final DioClient dioClient;

  SupportRemoteDataSourceImpl(this.dioClient);

  @override
  Future<SupportModel> getSupportInfo() async {
    try {
      final response = await dioClient.dio.get('/support/v1/');
      return SupportModel.fromJson(response.data);
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