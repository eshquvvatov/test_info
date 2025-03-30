
import '../../../../core/error/failer.dart';
import '../../../../core/resources/data_state.dart';
import '../entities/support_entity.dart';

abstract class SupportRepository {
  Future<Either<Failure, SupportEntity>> getSupportInfo();
}