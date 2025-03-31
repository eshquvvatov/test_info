// Mocks generated by Mockito 5.4.5 from annotations
// in aros_staff/test/features/home/domian/usecases/check_out_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i11;

import 'package:aros_staff/core/error/failer.dart' as _i5;
import 'package:aros_staff/core/network/network_info.dart' as _i14;
import 'package:aros_staff/core/resources/data_state.dart' as _i2;
import 'package:aros_staff/features/home/domain/entities/attendance_detail_entity.dart'
    as _i7;
import 'package:aros_staff/features/home/domain/entities/attendance_info_entity.dart'
    as _i13;
import 'package:aros_staff/features/home/domain/entities/check_in_entity.dart'
    as _i8;
import 'package:aros_staff/features/home/domain/entities/check_out_entity.dart'
    as _i9;
import 'package:aros_staff/features/home/domain/entities/check_state_entity.dart'
    as _i12;
import 'package:aros_staff/features/home/domain/entities/face_scan_entity.dart'
    as _i10;
import 'package:aros_staff/features/home/domain/entities/month_date_entity.dart'
    as _i6;
import 'package:aros_staff/features/home/domain/repositories/home_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [HomeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeRepository extends _i1.Mock implements _i3.HomeRepository {
  MockHomeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.MonthDateEntity>>>
  getCurrentMonthDates() =>
      (super.noSuchMethod(
            Invocation.method(#getCurrentMonthDates, []),
            returnValue: _i4.Future<
              _i2.Either<_i5.Failure, List<_i6.MonthDateEntity>>
            >.value(
              _FakeEither_0<_i5.Failure, List<_i6.MonthDateEntity>>(
                this,
                Invocation.method(#getCurrentMonthDates, []),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.MonthDateEntity>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.AttendanceDetailEntity>>
  getAttendanceDetail(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getAttendanceDetail, [id]),
            returnValue: _i4.Future<
              _i2.Either<_i5.Failure, _i7.AttendanceDetailEntity>
            >.value(
              _FakeEither_0<_i5.Failure, _i7.AttendanceDetailEntity>(
                this,
                Invocation.method(#getAttendanceDetail, [id]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i7.AttendanceDetailEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.CheckInEntity>> checkIn(
    String? lat,
    String? lon,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#checkIn, [lat, lon]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i8.CheckInEntity>>.value(
                  _FakeEither_0<_i5.Failure, _i8.CheckInEntity>(
                    this,
                    Invocation.method(#checkIn, [lat, lon]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i8.CheckInEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i9.CheckOutEntity>> checkOut(
    String? lat,
    String? lon,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#checkOut, [lat, lon]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i9.CheckOutEntity>>.value(
                  _FakeEither_0<_i5.Failure, _i9.CheckOutEntity>(
                    this,
                    Invocation.method(#checkOut, [lat, lon]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i9.CheckOutEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i10.FaceScanEntity>> faceScan(
    _i11.File? imageFile,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#faceScan, [imageFile]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i10.FaceScanEntity>>.value(
                  _FakeEither_0<_i5.Failure, _i10.FaceScanEntity>(
                    this,
                    Invocation.method(#faceScan, [imageFile]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i10.FaceScanEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i12.CheckStateEntity>> checkState() =>
      (super.noSuchMethod(
            Invocation.method(#checkState, []),
            returnValue: _i4.Future<
              _i2.Either<_i5.Failure, _i12.CheckStateEntity>
            >.value(
              _FakeEither_0<_i5.Failure, _i12.CheckStateEntity>(
                this,
                Invocation.method(#checkState, []),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i12.CheckStateEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i13.AttendanceInfoEntity>>
  getAttendanceInfo() =>
      (super.noSuchMethod(
            Invocation.method(#getAttendanceInfo, []),
            returnValue: _i4.Future<
              _i2.Either<_i5.Failure, _i13.AttendanceInfoEntity>
            >.value(
              _FakeEither_0<_i5.Failure, _i13.AttendanceInfoEntity>(
                this,
                Invocation.method(#getAttendanceInfo, []),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i13.AttendanceInfoEntity>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i14.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> checkConnectivity() =>
      (super.noSuchMethod(
            Invocation.method(#checkConnectivity, []),
            returnValue: _i4.Future<bool>.value(false),
          )
          as _i4.Future<bool>);
}
