
import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reset_password_entity.dart';
import '../repositories/auth_repository.dart';

class ResetNewPasswordUseCase implements UseCase<Either<Failure, ResetPasswordEntity>, ResetNewPasswordParams> {
  final AuthRepository _loginStarRepository;
  final NetworkInfo _connectivity = sl<NetworkInfo>();

  ResetNewPasswordUseCase(this._loginStarRepository);

  @override
  Future<Either<Failure, ResetPasswordEntity>> call({required ResetNewPasswordParams params}) async {
    // Check Internet Connection
    var connectivityResult = await _connectivity.checkConnectivity();
    if (!connectivityResult) {
      return FoldLeft(NetworkFailure(message: "Internet aloqasi yo‘q", statusCode: null));
    }
    return _loginStarRepository.resetNewPassword(params.phone, params.code, params.newPassword);
  }
}

class ResetNewPasswordParams {
  final String phone;
  final int code;
  final String newPassword;

  ResetNewPasswordParams({
    required this.phone,
    required this.code,
    required this.newPassword,
  });
}