
import '../../../../core/error/failer.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/support_entity.dart';
import '../repositories/support_repository.dart';

class GetSupportInfo implements UseCase<Either<Failure, SupportEntity>, Null> {
  final SupportRepository repository;

  GetSupportInfo(this.repository);

  @override
  Future<Either<Failure, SupportEntity>> call({ Null params}) async {
    return await repository.getSupportInfo();
  }

}