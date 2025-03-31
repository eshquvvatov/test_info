import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/auth/domain/entities/old_login_entity.dart';
import 'package:aros_staff/features/auth/domain/repositories/auth_repository.dart';
import 'package:aros_staff/features/auth/domain/usecases/old_login_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'old_login_usecase_test.mocks.dart';

@GenerateMocks([
  AuthRepository,
  NetworkInfo,
])
void main() {
  late OldLoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = OldLoginUseCase(mockAuthRepository, mockNetworkInfo);
  });

  final testParams = OldLoginParams(
    phone: '+998901234567',
    password: 'password123',
    autofillCode: '123456',
  );

  final testEntity = OldLoginEntity(
    message: 'Success',
    refresh: 'refresh_token',
    access: 'access_token',
  );

group('OldLoginUseCase', () {
  test('should check internet connection first', () async {
    // Arrange
    when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
    when(mockAuthRepository.oldLogin(any, any, any))
        .thenAnswer((_) async => FoldRight<Failure, OldLoginEntity>(testEntity));

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
    expect(result, isA<FoldLeft<Failure, OldLoginEntity>>());
    expect(result.leftOrThrow, isA<NetworkFailure>());
    verify(mockNetworkInfo.checkConnectivity());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should call repository with correct parameters when online', () async {
    // Arrange
    when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
    when(mockAuthRepository.oldLogin(any, any, any))
        .thenAnswer((_) async => FoldRight<Failure, OldLoginEntity>(testEntity));

    // Act
    await useCase.call(params: testParams);

    // Assert
    verify(mockAuthRepository.oldLogin(
      testParams.phone,
      testParams.password,
      testParams.autofillCode,
    ));
  });

  test('should return OldLoginEntity when repository call is successful', () async {
    // Arrange
    when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
    when(mockAuthRepository.oldLogin(any, any, any))
        .thenAnswer((_) async => FoldRight<Failure, OldLoginEntity>(testEntity));

    // Act
    final result = await useCase.call(params: testParams);

    // Assert
    expect(result, isA<FoldRight<Failure, OldLoginEntity>>());
    expect(result.rightOrThrow, equals(testEntity));
  });

  test('should return ServerFailure when repository call fails', () async {
    // Arrange
    final failure = ServerFailure(message: 'Error', statusCode: 500);
    when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
    when(mockAuthRepository.oldLogin(any, any, any))
        .thenAnswer((_) async => FoldLeft<Failure, OldLoginEntity>(failure));

    // Act
    final result = await useCase.call(params: testParams);

    // Assert
    expect(result, isA<FoldLeft<Failure, OldLoginEntity>>());
    expect(result.leftOrThrow, equals(failure));
  });
});
}