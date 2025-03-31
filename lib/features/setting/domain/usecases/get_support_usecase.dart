
import 'package:aros_staff/core/network/network_info.dart';

import '../../../../core/error/failer.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/support_entity.dart';
import '../repositories/support_repository.dart';

class GetSupportInfo implements UseCase<Either<Failure, SupportEntity>, Null> {
  final SupportRepository repository;
 final NetworkInfo _networkInfo;
  GetSupportInfo(this.repository,this._networkInfo);

  @override
  Future<Either<Failure, SupportEntity>> call({ Null params}) async {
    final isConnected = await _networkInfo.checkConnectivity();
     if (!isConnected) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return await repository.getSupportInfo();
  }

}