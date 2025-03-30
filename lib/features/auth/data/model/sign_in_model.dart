import 'package:aros_staff/features/auth/domain/entities/sign_in_entity.dart';

class SignInModel extends SignInEntity {
  SignInModel({required super.message});

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}