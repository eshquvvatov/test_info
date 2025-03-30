import '../../domain/entities/reset_otp_verify_entity.dart';

class ResetOtpVerifyModel extends ResetOtpVerifyEntity {
  ResetOtpVerifyModel({required super.message});

  factory ResetOtpVerifyModel.fromJson(Map<String, dynamic> json) {
    return ResetOtpVerifyModel(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}