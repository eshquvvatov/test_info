import '../../domain/entities/check_state_entity.dart';

class CheckStateModel extends CheckStateEntity {
  CheckStateModel({required super.state, required super.isCheckedIn, required super.isCheckedOut});

  factory CheckStateModel.fromJson(Map<String, dynamic> json) {
    return CheckStateModel(state: json['state'] as String, isCheckedIn: json['state'] =="check_in", isCheckedOut: json['state']=="check_out");
  }

  Map<String, dynamic> toJson() {
    return {'state': state};
  }
}