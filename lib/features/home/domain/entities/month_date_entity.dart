class MonthDateEntity {
  final int id;
  final String date;
  final String monthName;

  MonthDateEntity({
    required this.id,
    required this.date,
    required this.monthName
  });
  @override
  String toString() {

    return "${this.monthName}, ${this.id} ${this.date}";
  }
}