import '../../domain/entities/support_entity.dart';

class SupportModel extends SupportEntity {
  SupportModel({
    required super.phoneNumber,
    required super.email,
    required super.telegram,
    required super.address

  });

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      phoneNumber: json['phone']??"",
      email: json['email']??"",
        telegram: json['telegram']??"",
      address: json['address']??""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'email': email,
      'message': telegram,
    };
  }
}