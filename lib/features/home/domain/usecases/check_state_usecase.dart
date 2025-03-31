
import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/check_state_entity.dart';
import '../repositories/home_repository.dart';

class CheckStateUseCase implements UseCase<Either<Failure, CheckStateEntity>, Null> {
  final HomeRepository _repository;
  final NetworkInfo _networkInfo ;

  CheckStateUseCase(this._repository,this._networkInfo);

  @override
  Future<Either<Failure, CheckStateEntity>> call({ Null params}) async {
    final isConnected = await _networkInfo.checkConnectivity();
    if (!isConnected) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _repository.checkState();
  }
}

