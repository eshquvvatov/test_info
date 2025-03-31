import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/auth/domain/entities/reset_password_entity.dart';
import 'package:aros_staff/features/auth/domain/repositories/auth_repository.dart';
import 'package:aros_staff/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'reset_password_usecase_test.mocks.dart';

@GenerateMocks([
  AuthRepository,
  NetworkInfo,
])
void main() {
  late ResetNewPasswordUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = ResetNewPasswordUseCase(mockAuthRepository, mockNetworkInfo);
  });

  final testParams = ResetNewPasswordParams(
    phone: '+998901234567',
    code: 123456,
    newPassword: 'newSecurePassword123',
  );

  final testEntity = ResetPasswordEntity(
    message: 'Password reset successfully',
  );

  group('ResetNewPasswordUseCase', () {
    test('should check internet connection first', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockAuthRepository.resetNewPassword(any, any, any))
          .thenAnswer((_) async => FoldRight<Failure, ResetPasswordEntity>(testEntity));

      // Act
      await useCase.call(params: testParams);

      // Assert
      verify(mockNetworkInfo.checkConnectivity());
    });

    test('should return NetworkFailure when no internet connection', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => false);

      // Act
      final result = await useCase.call(params: testParams);

      // Assert
      expect(result, isA<FoldLeft<Failure, ResetPasswordEntity>>());
      expect(result.leftOrThrow, isA<NetworkFailure>());
      verify(mockNetworkInfo.checkConnectivity());
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should call repository with correct parameters when online', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockAuthRepository.resetNewPassword(any, any, any))
          .thenAnswer((_) async => FoldRight<Failure, ResetPasswordEntity>(testEntity));

      // Act
      await useCase.call(params: testParams);

      // Assert
      verify(mockAuthRepository.resetNewPassword(
        testParams.phone,
        testParams.code,
        testParams.newPassword,
      ));
    });

    test('should return ResetPasswordEntity when repository call is successful', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockAuthRepository.resetNewPassword(any, any, any))
          .thenAnswer((_) async => FoldRight<Failure, ResetPasswordEntity>(testEntity));

      // Act
      final result = await useCase.call(params: testParams);

      // Assert
      expect(result, isA<FoldRight<Failure, ResetPasswordEntity>>());
      expect(result.rightOrThrow, equals(testEntity));
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Error', statusCode: 500);
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockAuthRepository.resetNewPassword(any, any, any))
          .thenAnswer((_) async => FoldLeft<Failure, ResetPasswordEntity>(failure));

      // Act
      final result = await useCase.call(params: testParams);

      // Assert
      expect(result, isA<FoldLeft<Failure, ResetPasswordEntity>>());
      expect(result.leftOrThrow, equals(failure));
    });
  });
}