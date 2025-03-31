import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/home/domain/entities/month_date_entity.dart';
import 'package:aros_staff/features/home/domain/repositories/home_repository.dart';
import 'package:aros_staff/features/home/domain/usecases/get_current_month_dates_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_current_month_dates_usecase_test.mocks.dart';

@GenerateMocks([
  HomeRepository,
  NetworkInfo,
])
void main() {
  late GetCurrentMonthDatesUseCase useCase;
  late MockHomeRepository mockHomeRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = GetCurrentMonthDatesUseCase(mockHomeRepository, mockNetworkInfo);
  });

  final testDates = [
    MonthDateEntity(
      id: 1,
      date: '2023-01-01',
      monthName: 'January',
    ),
    MonthDateEntity(
      id: 2,
      date: '2023-01-02',
      monthName: 'January',
    ),
  ];

  group('GetCurrentMonthDatesUseCase', () {
    test('should check internet connection first', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getCurrentMonthDates())
          .thenAnswer((_) async => FoldRight<Failure, List<MonthDateEntity>>(testDates));

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
      expect(result, isA<FoldLeft<Failure, List<MonthDateEntity>>>());
      expect(result.leftOrThrow, isA<NetworkFailure>());
      verify(mockNetworkInfo.checkConnectivity());
      verifyNoMoreInteractions(mockHomeRepository);
    });

    test('should call repository method when online', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getCurrentMonthDates())
          .thenAnswer((_) async => FoldRight<Failure, List<MonthDateEntity>>(testDates));

      // Act
      await useCase.call();

      // Assert
      verify(mockHomeRepository.getCurrentMonthDates());
    });

    test('should return list of MonthDateEntity when successful', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getCurrentMonthDates())
          .thenAnswer((_) async => FoldRight<Failure, List<MonthDateEntity>>(testDates));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldRight<Failure, List<MonthDateEntity>>>());
      final dates = result.rightOrThrow;
      expect(dates.length, equals(2));
      expect(dates[0].id, equals(1));
      expect(dates[0].date, equals('2023-01-01'));
      expect(dates[0].monthName, equals('January'));
      expect(dates[1].id, equals(2));
      expect(dates[1].date, equals('2023-01-02'));
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Error', statusCode: 500);
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getCurrentMonthDates())
          .thenAnswer((_) async => FoldLeft<Failure, List<MonthDateEntity>>(failure));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldLeft<Failure, List<MonthDateEntity>>>());
      expect(result.leftOrThrow, equals(failure));
    });
  });
}