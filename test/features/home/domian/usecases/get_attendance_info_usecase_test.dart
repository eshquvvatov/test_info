import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/home/domain/entities/attendance_info_entity.dart';
import 'package:aros_staff/features/home/domain/repositories/home_repository.dart';
import 'package:aros_staff/features/home/domain/usecases/get_attendance_info_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_attendance_info_usecase_test.mocks.dart';

@GenerateMocks([
  HomeRepository,
  NetworkInfo,
])
void main() {
  late GetAttendanceInfoUseCase useCase;
  late MockHomeRepository mockHomeRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = GetAttendanceInfoUseCase(mockHomeRepository, mockNetworkInfo);
  });

  final testEntity = AttendanceInfoEntity(
    day: DayInfoEntity(
      start: '2023-01-01',
      end: '2023-01-31',
    ),
    attendance: AttendanceRecordEntity(
      checkIn: '09:00',
      checkOut: '18:00',
    ),
    stat: StatInfoEntity(
      on: 22,
      off: 8,
    ),
  );

  group('GetAttendanceInfoUseCase', () {
    test('should check internet connection first', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceInfo())
          .thenAnswer((_) async => FoldRight<Failure, AttendanceInfoEntity>(testEntity));

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
      expect(result, isA<FoldLeft<Failure, AttendanceInfoEntity>>());
      expect(result.leftOrThrow, isA<NetworkFailure>());
      verify(mockNetworkInfo.checkConnectivity());
      verifyNoMoreInteractions(mockHomeRepository);
    });

    test('should call repository method when online', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceInfo())
          .thenAnswer((_) async => FoldRight<Failure, AttendanceInfoEntity>(testEntity));

      // Act
      await useCase.call();

      // Assert
      verify(mockHomeRepository.getAttendanceInfo());
    });

    test('should return AttendanceInfoEntity with all nested data when successful', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceInfo())
          .thenAnswer((_) async => FoldRight<Failure, AttendanceInfoEntity>(testEntity));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldRight<Failure, AttendanceInfoEntity>>());
      final entity = result.rightOrThrow;
      expect(entity.day.start, equals('2023-01-01'));
      expect(entity.day.end, equals('2023-01-31'));
      expect(entity.attendance.checkIn, equals('09:00'));
      expect(entity.attendance.checkOut, equals('18:00'));
      expect(entity.stat.on, equals(22));
      expect(entity.stat.off, equals(8));
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Error', statusCode: 500);
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceInfo())
          .thenAnswer((_) async => FoldLeft<Failure, AttendanceInfoEntity>(failure));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldLeft<Failure, AttendanceInfoEntity>>());
      expect(result.leftOrThrow, equals(failure));
    });
  });
}