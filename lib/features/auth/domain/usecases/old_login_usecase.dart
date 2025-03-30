
import '../../../../core/error/failer.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/old_login_entity.dart';
import '../repositories/auth_repository.dart';



class OldLoginUseCase implements UseCase<Either<Failure, OldLoginEntity>, OldLoginParams> {
  final AuthRepository _loginStarRepository;
  OldLoginUseCase(this._loginStarRepository);
  final  NetworkInfo _connectivity = sl<NetworkInfo>();

  @override
  Future<Either<Failure, OldLoginEntity>> call({required OldLoginParams params}) async{
    // Check Internet Connection
    var connectivityResult = await _connectivity.checkConnectivity();
    if (!connectivityResult) {
      return FoldLeft(const NetworkFailure(message:"Internet aloqasi yo'q" ,statusCode:null ));
    }
    return _loginStarRepository.oldLogin(params.phone, params.password, params.autofillCode);
  }

}


class OldLoginParams {
  final String phone;
  final String password;
  final String? autofillCode;

  OldLoginParams({
    required this.phone,
    required this.password,
    required this.autofillCode,
  });
}