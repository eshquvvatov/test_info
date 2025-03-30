part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadingMonthAndDayInfoEvent extends HomeEvent{}

class SelectDayEvent extends HomeEvent{
  final String day;
  final int dayId;
  const SelectDayEvent({required this.day,required this.dayId});
}

class GetDetailAttendanceEvent extends HomeEvent{
 final int id;
 GetDetailAttendanceEvent({required this.id});
}