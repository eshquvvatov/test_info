class AttendanceInfoEntity {
  final DayInfoEntity day;
  final AttendanceRecordEntity attendance;
  final StatInfoEntity stat;

  AttendanceInfoEntity({
    required this.day,
    required this.attendance,
    required this.stat,
  });
}

class DayInfoEntity {
  final String start;
  final String end;

  DayInfoEntity({
    required this.start,
    required this.end,
  });
}

class AttendanceRecordEntity {
  final String? checkIn;
  final String? checkOut;

  AttendanceRecordEntity({
    this.checkIn,
    this.checkOut,
  });
}

class StatInfoEntity {
  final int on;
  final int off;

  StatInfoEntity({
    required this.on,
    required this.off,
  });
}