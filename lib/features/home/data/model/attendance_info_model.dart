import '../../domain/entities/attendance_info_entity.dart';

class AttendanceInfoModel extends AttendanceInfoEntity {
  AttendanceInfoModel({
    required super.day,
    required super.attendance,
    required super.stat,
  });

  factory AttendanceInfoModel.fromJson(Map<String, dynamic> json) {
    return AttendanceInfoModel(
      day: DayInfoModel.fromJson(json['day']),
      attendance: AttendanceRecordModel.fromJson(json['attendance']),
      stat: StatInfoModel.fromJson(json['stat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': (day as DayInfoModel).toJson(),
      'attendance': (attendance as AttendanceRecordModel).toJson(),
      'stat': (stat as StatInfoModel).toJson(),
    };
  }
}

class DayInfoModel extends DayInfoEntity {
  DayInfoModel({required super.start, required super.end});

  factory DayInfoModel.fromJson(Map<String, dynamic> json) {
    return DayInfoModel(
      start: json['start'].toString(),
      end: json['end'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'start': start, 'end': end};
  }
}

class AttendanceRecordModel extends AttendanceRecordEntity {
  AttendanceRecordModel({super.checkIn, super.checkOut});

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'check_in': checkIn, 'check_out': checkOut};
  }
}

class StatInfoModel extends StatInfoEntity {
  StatInfoModel({required super.on, required super.off});

  factory StatInfoModel.fromJson(Map<String, dynamic> json) {
    return StatInfoModel(
      on: json['on'] as int,
      off: json['off'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'on': on, 'off': off};
  }
}