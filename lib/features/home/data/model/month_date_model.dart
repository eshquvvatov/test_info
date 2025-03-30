import '../../domain/entities/month_date_entity.dart';

class MonthDateModel extends MonthDateEntity {
  MonthDateModel({
    required super.id,
    required super.date,
    required super.monthName
  });

  factory MonthDateModel.fromJson(Map<String, dynamic> json) {
    return MonthDateModel(
      id: json['id'] as int,
      date: json['date'] as String,
      monthName:_getMonthName(DateTime.parse(json["date"]).month)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
    };
  }

 static String _getMonthName(int month) {

    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    return months[month - 1];
  }
}