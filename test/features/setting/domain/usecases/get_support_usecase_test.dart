import 'package:aros_staff/core/error/failer.dart';
import 'package:aros_staff/core/network/network_info.dart';
import 'package:aros_staff/core/resources/data_state.dart';
import 'package:aros_staff/features/setting/domain/entities/support_entity.dart';
import 'package:aros_staff/features/setting/domain/repositories/support_repository.dart';
import 'package:aros_staff/features/setting/domain/usecases/get_support_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_support_usecase_test.mocks.dart';

@GenerateMocks([
  SupportRepository,
  NetworkInfo,
])
void main() {
  late GetSupportInfo useCase;
  late MockSupportRepository mockRepository;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRepository = MockSupportRepository();
    mockNetworkInfo = MockNetworkInfo();
    useCase = GetSupportInfo(mockRepository, mockNetworkInfo);
  });

  final testEntity = SupportEntity(
    phoneNumber: '+998901234567',
    email: 'support@aros.com',
    telegram: '@arossupport',
    address: 'Tashkent, Uzbekistan',
  );

  group('GetSupportInfo', () {
    test('should check internet connection first', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockRepository.getSupportInfo())
          .thenAnswer((_) async => FoldRight<Failure, SupportEntity>(testEntity));

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
      expect(result, isA<FoldLeft<Failure, SupportEntity>>());
      expect(result.leftOrThrow, isA<NetworkFailure>());
      verify(mockNetworkInfo.checkConnectivity());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should call repository method when online', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockRepository.getSupportInfo())
          .thenAnswer((_) async => FoldRight<Failure, SupportEntity>(testEntity));

      // Act
      await useCase.call();

      // Assert
      verify(mockRepository.getSupportInfo());
    });

    test('should return SupportEntity with all fields when successful', () async {
      // Arrange
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockRepository.getSupportInfo())
          .thenAnswer((_) async => FoldRight<Failure, SupportEntity>(testEntity));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldRight<Failure, SupportEntity>>());
      final supportInfo = result.rightOrThrow;
      expect(supportInfo.phoneNumber, equals('+998901234567'));
      expect(supportInfo.email, equals('support@aros.com'));
      expect(supportInfo.telegram, equals('@arossupport'));
      expect(supportInfo.address, equals('Tashkent, Uzbekistan'));
    });

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure(message: 'Error', statusCode: 500);
      when(mockNetworkInfo.checkConnectivity()).thenAnswer((_) async => true);
      when(mockRepository.getSupportInfo())
          .thenAnswer((_) async => FoldLeft<Failure, SupportEntity>(failure));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<FoldLeft<Failure, SupportEntity>>());
      expect(result.leftOrThrow, equals(failure));
    });
  });
}