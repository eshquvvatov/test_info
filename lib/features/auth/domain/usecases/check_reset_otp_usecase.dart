
import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reset_otp_verify_entity.dart';
import '../repositories/auth_repository.dart';

class ResetCheckOtpUseCase implements UseCase<Either<Failure, ResetOtpVerifyEntity>, ResetCheckOtpParams> {
  final AuthRepository _loginStarRepository;
  final NetworkInfo _connectivity = sl<NetworkInfo>();

  ResetCheckOtpUseCase(this._loginStarRepository);

  @override
  Future<Either<Failure, ResetOtpVerifyEntity>> call({required ResetCheckOtpParams params}) async {
    // Check Internet Connection
    var connectivityResult = await _connectivity.checkConnectivity();
    if (!connectivityResult) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _loginStarRepository.resetCheckOtp(params.phone, params.code);
  }
}

class ResetCheckOtpParams {
  final String phone;
  final int code;

  ResetCheckOtpParams({
    required this.phone,
    required this.code,
  });
}