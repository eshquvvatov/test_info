part of 'main_bloc.dart';

abstract class MainEvent  {
  const MainEvent();
}


class ChangeNavigationEvent extends MainEvent{
  final int currentPage;
  const ChangeNavigationEvent({required this.currentPage});
}

class CheckInitEvent extends MainEvent{}

class CheckInEvent extends MainEvent{
  final String lat;
  final String lon;
  CheckInEvent({required this.lat,required this.lon});
}

class CheckOutEvent extends MainEvent{
  final String lat;
  final String lon;
  CheckOutEvent({required this.lat,required this.lon});
}