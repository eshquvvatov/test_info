
import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/month_date_entity.dart';
import '../repositories/home_repository.dart';

class GetCurrentMonthDatesUseCase
    implements UseCase<Either<Failure, List<MonthDateEntity>>, Null> {
  final HomeRepository _repository;
  final NetworkInfo _networkInfo = sl<NetworkInfo>();

  GetCurrentMonthDatesUseCase(this._repository);

  @override
  Future<Either<Failure, List<MonthDateEntity>>> call({ Null params}) async {
    final isConnected = await _networkInfo.checkConnectivity();
    if (!isConnected) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _repository.getCurrentMonthDates();
  }
}

