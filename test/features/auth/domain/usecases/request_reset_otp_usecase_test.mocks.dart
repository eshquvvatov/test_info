// Mocks generated by Mockito 5.4.5 from annotations
// in aros_staff/test/features/auth/domain/usecases/request_reset_otp_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:aros_staff/core/error/failer.dart' as _i5;
import 'package:aros_staff/core/network/network_info.dart' as _i10;
import 'package:aros_staff/core/resources/data_state.dart' as _i2;
import 'package:aros_staff/features/auth/domain/entities/old_login_entity.dart'
    as _i6;
import 'package:aros_staff/features/auth/domain/entities/reset_otp_entity.dart'
    as _i7;
import 'package:aros_staff/features/auth/domain/entities/reset_otp_verify_entity.dart'
    as _i8;
import 'package:aros_staff/features/auth/domain/entities/reset_password_entity.dart'
    as _i9;
import 'package:aros_staff/features/auth/domain/repositories/auth_repository.dart'
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

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.OldLoginEntity>> oldLogin(
    String? phone,
    String? password,
    String? autofillCode,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#oldLogin, [phone, password, autofillCode]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i6.OldLoginEntity>>.value(
                  _FakeEither_0<_i5.Failure, _i6.OldLoginEntity>(
                    this,
                    Invocation.method(#oldLogin, [
                      phone,
                      password,
                      autofillCode,
                    ]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i6.OldLoginEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.ResetOtpEntity>> resetOtp(
    String? phone,
    String? autofillCode,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#resetOtp, [phone, autofillCode]),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i7.ResetOtpEntity>>.value(
                  _FakeEither_0<_i5.Failure, _i7.ResetOtpEntity>(
                    this,
                    Invocation.method(#resetOtp, [phone, autofillCode]),
                  ),
                ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i7.ResetOtpEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.ResetOtpVerifyEntity>> resetCheckOtp(
    String? phone,
    int? code,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#resetCheckOtp, [phone, code]),
            returnValue: _i4.Future<
              _i2.Either<_i5.Failure, _i8.ResetOtpVerifyEntity>
            >.value(
              _FakeEither_0<_i5.Failure, _i8.ResetOtpVerifyEntity>(
                this,
                Invocation.method(#resetCheckOtp, [phone, code]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i8.ResetOtpVerifyEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i9.ResetPasswordEntity>> resetNewPassword(
    String? phone,
    int? code,
    String? newPassword,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#resetNewPassword, [phone, code, newPassword]),
            returnValue: _i4.Future<
              _i2.Either<_i5.Failure, _i9.ResetPasswordEntity>
            >.value(
              _FakeEither_0<_i5.Failure, _i9.ResetPasswordEntity>(
                this,
                Invocation.method(#resetNewPassword, [
                  phone,
                  code,
                  newPassword,
                ]),
              ),
            ),
          )
          as _i4.Future<_i2.Either<_i5.Failure, _i9.ResetPasswordEntity>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i10.NetworkInfo {
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
