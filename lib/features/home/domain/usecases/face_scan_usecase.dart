import 'dart:io';
import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/face_scan_entity.dart';
import '../repositories/home_repository.dart';

class FaceScanUseCase implements UseCase<Either<Failure, FaceScanEntity>, FaceScanParams> {
  final HomeRepository _repository;
  final NetworkInfo _networkInfo ;

  FaceScanUseCase(this._repository,this._networkInfo);

  @override
  Future<Either<Failure, FaceScanEntity>> call({required FaceScanParams params}) async {
    final isConnected = await _networkInfo.checkConnectivity();
    if (!isConnected) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _repository.faceScan(params.imageFile);
  }
}

class FaceScanParams {
  final File imageFile;

  FaceScanParams({required this.imageFile});
}