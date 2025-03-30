import 'dart:io';


import '../../../../core/error/failer.dart';
import '../../../../core/resources/data_state.dart';
import '../entities/attendance_detail_entity.dart';
import '../entities/attendance_info_entity.dart';
import '../entities/check_in_entity.dart';
import '../entities/check_out_entity.dart';
import '../entities/check_state_entity.dart';
import '../entities/face_scan_entity.dart';
import '../entities/month_date_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MonthDateEntity>>> getCurrentMonthDates();
  Future<Either<Failure, AttendanceDetailEntity>> getAttendanceDetail(int id);
  Future<Either<Failure, CheckInEntity>> checkIn(String lat, String lon);
  Future<Either<Failure, CheckOutEntity>> checkOut(String lat, String lon);
  Future<Either<Failure, FaceScanEntity>> faceScan(File imageFile);
  Future<Either<Failure, CheckStateEntity>> checkState();
  Future<Either<Failure, AttendanceInfoEntity>> getAttendanceInfo();
}