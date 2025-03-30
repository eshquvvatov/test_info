import '../../domain/entities/otp_entity.dart';

class OtpModel extends OtpEntity {
  OtpModel({
    required super.message,
    required super.refresh,
    required super.access,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      message: json['message'],
      refresh: json['refresh'],
      access: json['access'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'refresh': refresh,
      'access': access,
    };
  }
}