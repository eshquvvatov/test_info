import '../../domain/entities/reset_otp_entity.dart';

class ResetOtpModel extends ResetOtpEntity {
  ResetOtpModel({required super.message});

  factory ResetOtpModel.fromJson(Map<String, dynamic> json) {
    return ResetOtpModel(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}