import '../../domain/entities/attendance_detail_entity.dart';

class AttendanceDetailModel extends AttendanceDetailEntity {
  AttendanceDetailModel({
    required super.id,
    required super.checkIn,
    required super.checkOut,
    required super.dailyResult,
  });

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailModel(
      id: json['id']??0,
      checkIn: json['check_in'].toString() ,
      checkOut: json['check_out'].toString() ,
      dailyResult: json['daily_result']??0 ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'check_in': checkIn,
      'check_out': checkOut,
      'daily_result': dailyResult,
    };
  }
}