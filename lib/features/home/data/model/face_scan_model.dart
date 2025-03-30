import '../../domain/entities/face_scan_entity.dart';

class FaceScanModel extends FaceScanEntity {
  FaceScanModel({required super.message});

  factory FaceScanModel.fromJson(Map<String, dynamic> json) {
    return FaceScanModel(message: json['message'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}