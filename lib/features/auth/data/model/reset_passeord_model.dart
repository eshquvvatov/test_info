import '../../domain/entities/reset_password_entity.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  ResetPasswordModel({required super.message});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}