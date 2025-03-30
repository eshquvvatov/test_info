part of 'home_bloc.dart';


enum HomePageState{init,loading,error,success}

class HomeState extends Equatable {
    final List<MonthDateEntity> dates;
  final String selectDay;
  final AttendanceInfoEntity? attendanceInfoEntity;
  final AttendanceDetailEntity? detailEntity;
  final HomePageState pageState;
  const HomeState({required this.detailEntity,required this.pageState,required this.dates, required this.selectDay,required this.attendanceInfoEntity});

  HomeState copyWith({
    List<MonthDateEntity>? dates,
    String? selectDay,
    AttendanceInfoEntity? attendanceInfoEntity,
    HomePageState? pageState,
    AttendanceDetailEntity? detailEntity
  }) {
    return HomeState(
      detailEntity: detailEntity??this.detailEntity,
      attendanceInfoEntity: attendanceInfoEntity??this.attendanceInfoEntity,
      dates: dates ?? this.dates,
      selectDay: selectDay ?? this.selectDay,
        pageState:  pageState??this.pageState
    );
  }

  @override
  List<Object?> get props => [selectDay, dates,attendanceInfoEntity,pageState,detailEntity];
}


