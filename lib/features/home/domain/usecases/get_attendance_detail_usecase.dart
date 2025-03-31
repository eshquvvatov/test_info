import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_detail_entity.dart';
import '../repositories/home_repository.dart';

class GetAttendanceDetailUseCase
    implements UseCase<Either<Failure, AttendanceDetailEntity>, GetAttendanceDetailParams> {
  final HomeRepository _repository;
  final NetworkInfo _networkInfo;

  GetAttendanceDetailUseCase(this._repository,this._networkInfo);

  @override
  Future<Either<Failure, AttendanceDetailEntity>> call(
      {required GetAttendanceDetailParams params}) async {
    final isConnected = await _networkInfo.checkConnectivity();
    if (!isConnected) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _repository.getAttendanceDetail(params.id);
  }
}

class GetAttendanceDetailParams {
  final int id;

  GetAttendanceDetailParams({required this.id});
}