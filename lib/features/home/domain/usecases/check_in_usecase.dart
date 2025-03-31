import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_in_entity.dart';
import '../repositories/home_repository.dart';

class CheckInUseCase implements UseCase<Either<Failure, CheckInEntity>, CheckInParams> {
  final HomeRepository _repository;
  final NetworkInfo _networkInfo;

  CheckInUseCase(this._repository,this._networkInfo);

  @override
  Future<Either<Failure, CheckInEntity>> call({required CheckInParams params}) async {
    final isConnected = await _networkInfo.checkConnectivity();
    if (!isConnected) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _repository.checkIn(params.lat, params.lon);
  }
}

class CheckInParams {
  final String lat;
  final String lon;

  CheckInParams({required this.lat, required this.lon});
}