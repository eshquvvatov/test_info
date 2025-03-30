
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:aros_staff/core/network/api_client.dart';
import '../../../../../core/constants/api.dart';
import '../../../../../core/error/failer.dart';
import '../../model/attendance_detail_model.dart';
import '../../model/attendance_info_model.dart';
import '../../model/check_in_model.dart';
import '../../model/check_out_model.dart';
import '../../model/check_state_model.dart';
import '../../model/face_scan_model.dart';
import '../../model/month_date_model.dart';


abstract class HomeRemoteDataSource {
  Future<List<MonthDateModel>> getCurrentMonthDates();
  Future<AttendanceDetailModel> getAttendanceDetail(int id);
  Future<CheckInModel> checkIn(String lat, String lon);
  Future<CheckOutModel> checkOut(String lat, String lon);
  Future<FaceScanModel> faceScan(File imageFile);
  Future<CheckStateModel> checkState();
  Future<AttendanceInfoModel> getAttendanceInfo();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<MonthDateModel>> getCurrentMonthDates() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.getMonthDates);

      final List<dynamic> data = response.data;
      var objects =  data.map((json) => MonthDateModel.fromJson(json)).toList();
      // List<MonthDateModel> correctDate = [];
      // for(var a in objects){
      //   if(DateTime.parse(a.date).month == DateTime.now().month){
      //     correctDate.add(a);
      //   }
      // }
      // return correctDate;
      return objects;

    } on DioException catch (e) {
      throw ServerFailure(message:_handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<AttendanceDetailModel> getAttendanceDetail(int id) async {
    try {

      final response = await dioClient.dio.get("${ApiConstants.attendanceDetail}$id/");
      return AttendanceDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message:_handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<CheckInModel> checkIn(String lat, String lon) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.checkIn,
        data: {'lat': lat, 'lon': lon},
      );
      return CheckInModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message:_handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<CheckOutModel> checkOut(String lat, String lon) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.checkOut,
        data: {'lat': lat, 'lon': lon},
      );
      return CheckOutModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message:_handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<FaceScanModel> faceScan(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
      });
      final response = await dioClient.dio.post(
        ApiConstants.faceScan,
        data: formData,
      );
      return FaceScanModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message:_handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<CheckStateModel> checkState() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.checkState);
      return CheckStateModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message:_handleDioError(e),statusCode: e.response?.statusCode);
    }
  }

  @override
  Future<AttendanceInfoModel> getAttendanceInfo() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.attendanceInfo);
      return AttendanceInfoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(message:_handleDioError(e),statusCode: e.response?.statusCode);
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


