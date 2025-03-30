
import '../../../../core/error/failer.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/support_entity.dart';
import '../../domain/repositories/support_repository.dart';
import '../data_source/remote/support_remote_datasource.dart';

class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDataSource remoteDataSource;

  SupportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SupportEntity>> getSupportInfo() async {
    try {
      final supportInfo = await remoteDataSource.getSupportInfo();
      return FoldRight(supportInfo); 
    } on ServerFailure catch (e) {
      return FoldLeft(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}