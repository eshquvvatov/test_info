import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/home/domain/entities/check_state_entity.dart';
import 'package:aros_staff/features/home/domain/repositories/home_repository.dart';
import 'package:aros_staff/features/home/domain/usecases/check_state_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'check_state_usecase_test.mocks.dart';

@GenerateMocks([
  HomeRepository,
  NetworkInfo,
])
void main() {
  late CheckStateUseCase useCase;
  late MockHomeRepository mockHomeRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = CheckStateUseCase(mockHomeRepository, mockNetworkInfo);
  });

  final testEntity = CheckStateEntity(
    state: 'check_in',
    isCheckedIn: true,
    isCheckedOut: false,
  );

  group('CheckStateUseCase', () {
    test('should check internet connection first', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkState())
          .thenAnswer((_) async => FoldRight<Failure, CheckStateEntity>(testEntity));

      // Act
      await useCase.call();

      // Assert
      verify(mockNetworkInfo.checkConnectivity());
    });

    test('should return NetworkFailure when no internet connection', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => false);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldLeft<Failure, CheckStateEntity>>());
      expect(result.leftOrThrow, isA<NetworkFailure>());
      verify(mockNetworkInfo.checkConnectivity());
      verifyNoMoreInteractions(mockHomeRepository);
    });

    test('should call repository method when online', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkState())
          .thenAnswer((_) async => FoldRight<Failure, CheckStateEntity>(testEntity));

      // Act
      await useCase.call();

      // Assert
      verify(mockHomeRepository.checkState());
    });

    test('should return CheckStateEntity when repository call is successful', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkState())
          .thenAnswer((_) async => FoldRight<Failure, CheckStateEntity>(testEntity));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldRight<Failure, CheckStateEntity>>());
      expect(result.rightOrThrow, equals(testEntity));
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Error', statusCode: 500);
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.checkState())
          .thenAnswer((_) async => FoldLeft<Failure, CheckStateEntity>(failure));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldLeft<Failure, CheckStateEntity>>());
      expect(result.leftOrThrow, equals(failure));
    });
  });
}