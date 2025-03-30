abstract class Failure {
  final String? message;
  final int? statusCode;
  const Failure({required this.message, required this.statusCode});
}

class ServerFailure extends Failure{
 const ServerFailure({required super.message,required super.statusCode});
}


class NetworkFailure extends Failure{
  const NetworkFailure({required super.message,required super.statusCode});
}

