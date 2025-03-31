import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_out_entity.dart';
import '../repositories/home_repository.dart';

class CheckOutUseCase implements UseCase<Either<Failure, CheckOutEntity>, CheckOutParams> {
  final HomeRepository _repository;
  final NetworkInfo _networkInfo ;

  CheckOutUseCase(this._repository,this._networkInfo);

  @override
  Future<Either<Failure, CheckOutEntity>> call({required CheckOutParams params}) async {
    final isConnected = await _networkInfo.checkConnectivity();
    if (!isConnected) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _repository.checkOut(params.lat, params.lon);
  }
}

class CheckOutParams {
  final String lat;
  final String lon;

  CheckOutParams({required this.lat, required this.lon});
}