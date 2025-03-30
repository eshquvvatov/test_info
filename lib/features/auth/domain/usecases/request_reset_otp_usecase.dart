
import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reset_otp_entity.dart';
import '../repositories/auth_repository.dart';

class ResetOtpUseCase implements UseCase<Either<Failure, ResetOtpEntity>, ResetOtpParams> {
  final AuthRepository _loginStarRepository;
  final NetworkInfo _connectivity = sl<NetworkInfo>();

  ResetOtpUseCase(this._loginStarRepository);

  @override
  Future<Either<Failure, ResetOtpEntity>> call({required ResetOtpParams params}) async {

    var connectivityResult = await _connectivity.checkConnectivity();
    if (!connectivityResult) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _loginStarRepository.resetOtp(params.phone, params.autofillCode);
  }
}

class ResetOtpParams {
  final String phone;
  final String autofillCode;

  ResetOtpParams({
    required this.phone,
    required this.autofillCode,
  });
}