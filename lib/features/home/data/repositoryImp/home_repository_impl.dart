
import 'dart:io';

import 'package:aros_staff/core/error/failer.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/entities/attendance_detail_entity.dart';
import '../../domain/entities/attendance_info_entity.dart';
import '../../domain/entities/check_in_entity.dart';
import '../../domain/entities/check_out_entity.dart';
import '../../domain/entities/check_state_entity.dart';
import '../../domain/entities/face_scan_entity.dart';
import '../../domain/entities/month_date_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/remote/home_remote_datasource.dart';


class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MonthDateEntity>>> getCurrentMonthDates() async {
    try {
      final result = await remoteDataSource.getCurrentMonthDates();
      return FoldRight(result);
    } on ServerFailure catch (e) {

      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, AttendanceDetailEntity>> getAttendanceDetail(int id) async {
    try {
      final result = await remoteDataSource.getAttendanceDetail(id);
      return FoldRight(result);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, CheckInEntity>> checkIn(String lat, String lon) async {
    try {
      final result = await remoteDataSource.checkIn(lat, lon);
      return FoldRight(result);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, CheckOutEntity>> checkOut(String lat, String lon) async {
    try {
      final result = await remoteDataSource.checkOut(lat, lon);
      return FoldRight(result);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, FaceScanEntity>> faceScan(File imageFile) async {
    try {
      final result = await remoteDataSource.faceScan(imageFile);
      return FoldRight(result);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, CheckStateEntity>> checkState() async {
    try {
      final result = await remoteDataSource.checkState();
      return FoldRight(result);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }

  @override
  Future<Either<Failure, AttendanceInfoEntity>> getAttendanceInfo() async {
    try {
      final result = await remoteDataSource.getAttendanceInfo();
      return FoldRight(result);
    } on ServerFailure catch (e) {
      return FoldLeft(e);
    }
  }
}