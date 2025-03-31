import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/home/domain/entities/check_in_entity.dart';
import 'package:aros_staff/features/home/domain/repositories/home_repository.dart';
import 'package:aros_staff/features/home/domain/usecases/check_in_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'check_in_usecase_test.mocks.dart';

@GenerateMocks([
  HomeRepository,
  NetworkInfo,
])
void main() {
  late CheckInUseCase useCase;
  late MockHomeRepository mockHomeRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = CheckInUseCase(mockHomeRepository, mockNetworkInfo);
  });

  final testParams = CheckInParams(
    lat: '41.311081',
    lon: '69.240562',
  );

  final testEntity = CheckInEntity(
    message: 'Checked in successfully',
  );

  group('CheckInUseCase', () {
    test('should check internet connection first', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkIn(any, any))
          .thenAnswer((_) async => FoldRight<Failure, CheckInEntity>(testEntity));

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
      expect(result, isA<FoldLeft<Failure, CheckInEntity>>());
      expect(result.leftOrThrow, isA<NetworkFailure>());
      verify(mockNetworkInfo.checkConnectivity());
      verifyNoMoreInteractions(mockHomeRepository);
    });

    test('should call repository with correct parameters when online', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkIn(any, any))
          .thenAnswer((_) async => FoldRight<Failure, CheckInEntity>(testEntity));

      // Act
      await useCase.call(params: testParams);

      // Assert
      verify(mockHomeRepository.checkIn(
        testParams.lat,
        testParams.lon,
      ));
    });

    test('should return CheckInEntity when repository call is successful', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkIn(any, any))
          .thenAnswer((_) async => FoldRight<Failure, CheckInEntity>(testEntity));

      // Act
      final result = await useCase.call(params: testParams);

      // Assert
      expect(result, isA<FoldRight<Failure, CheckInEntity>>());
      expect(result.rightOrThrow, equals(testEntity));
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Error', statusCode: 500);
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkIn(any, any))
          .thenAnswer((_) async => FoldLeft<Failure, CheckInEntity>(failure));

      // Act
      final result = await useCase.call(params: testParams);

      // Assert
      expect(result, isA<FoldLeft<Failure, CheckInEntity>>());
      expect(result.leftOrThrow, equals(failure));
    });
  });
}