
class CustomException implements Exception{
  final String? message;
  final int? statusCode;
  CustomException({required this.statusCode, required this.message});
  @override
  String toString() {
    return "message: $message \n statusCode: $statusCode";
  }

}