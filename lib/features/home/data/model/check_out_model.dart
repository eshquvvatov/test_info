import '../../domain/entities/check_out_entity.dart';

class CheckOutModel extends CheckOutEntity {
  CheckOutModel({required super.message});

  factory CheckOutModel.fromJson(Map<String, dynamic> json) {
    return CheckOutModel(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}