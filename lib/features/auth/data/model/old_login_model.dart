import '../../domain/entities/old_login_entity.dart';

class OldLoginModel extends OldLoginEntity {
  OldLoginModel({
    required super.message,
    required super.refresh,
    required super.access,
  });

  factory OldLoginModel.fromJson(Map<String, dynamic> json) {
    return OldLoginModel(
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