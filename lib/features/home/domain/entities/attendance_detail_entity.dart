class AttendanceDetailEntity {
  final int id;
  final String checkIn;
  final String checkOut;
  final num dailyResult;

  AttendanceDetailEntity({
    required this.id,
    required this.checkIn,
    required this.checkOut,
    required this.dailyResult,
  });
}