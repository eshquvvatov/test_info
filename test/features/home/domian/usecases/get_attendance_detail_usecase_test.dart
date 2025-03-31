import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/home/domain/entities/attendance_detail_entity.dart';
import 'package:aros_staff/features/home/domain/repositories/home_repository.dart';
import 'package:aros_staff/features/home/domain/usecases/get_attendance_detail_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_attendance_detail_usecase_test.mocks.dart';

@GenerateMocks([
  HomeRepository,
  NetworkInfo,
])
void main() {
  late GetAttendanceDetailUseCase useCase;
  late MockHomeRepository mockHomeRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = GetAttendanceDetailUseCase(mockHomeRepository, mockNetworkInfo);
  });

  final testParams = GetAttendanceDetailParams(id: 1);
  final testEntity = AttendanceDetailEntity(
    id: 1,
    checkIn: '2023-01-01 09:00:00',
    checkOut: '2023-01-01 18:00:00',
    dailyResult: 8.5,
  );

  group('GetAttendanceDetailUseCase', () {
    test('should check internet connection first', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceDetail(any))
          .thenAnswer((_) async => FoldRight<Failure, AttendanceDetailEntity>(testEntity));

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
      expect(result, isA<FoldLeft<Failure, AttendanceDetailEntity>>());
      expect(result.leftOrThrow, isA<NetworkFailure>());
      verify(mockNetworkInfo.checkConnectivity());
      verifyNoMoreInteractions(mockHomeRepository);
    });

    test('should call repository with correct id parameter when online', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceDetail(any))
          .thenAnswer((_) async => FoldRight<Failure, AttendanceDetailEntity>(testEntity));

      // Act
      await useCase.call(params: testParams);

      // Assert
      verify(mockHomeRepository.getAttendanceDetail(testParams.id));
    });

    test('should return AttendanceDetailEntity when repository call is successful', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceDetail(any))
          .thenAnswer((_) async => FoldRight<Failure, AttendanceDetailEntity>(testEntity));

      // Act
      final result = await useCase.call(params: testParams);

      // Assert
      expect(result, isA<FoldRight<Failure, AttendanceDetailEntity>>());
      expect(result.rightOrThrow, equals(testEntity));
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Error', statusCode: 404);
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockHomeRepository.getAttendanceDetail(any))
          .thenAnswer((_) async => FoldLeft<Failure, AttendanceDetailEntity>(failure));

      // Act
      final result = await useCase.call(params: testParams);

      // Assert
      expect(result, isA<FoldLeft<Failure, AttendanceDetailEntity>>());
      expect(result.leftOrThrow, equals(failure));
    });
  });
}