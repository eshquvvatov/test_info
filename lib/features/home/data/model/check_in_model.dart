import '../../domain/entities/check_in_entity.dart';

class CheckInModel extends CheckInEntity {
  CheckInModel({required super.message});

  factory CheckInModel.fromJson(Map<String, dynamic> json) {
    return CheckInModel(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}