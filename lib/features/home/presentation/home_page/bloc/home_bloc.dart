
import 'package:aros_staff/core/utils/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/attendance_detail_entity.dart';
import '../../../domain/entities/attendance_info_entity.dart';
import '../../../domain/entities/month_date_entity.dart';
import '../../../domain/usecases/get_attendance_detail_usecase.dart';
import '../../../domain/usecases/get_attendance_info_usecase.dart';
import '../../../domain/usecases/get_current_month_dates_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentMonthDatesUseCase getCurrentMonthDatesUseCase;
  final GetAttendanceInfoUseCase getAttendanceInfoUseCase;
  final GetAttendanceDetailUseCase detailUseCase;

  HomeBloc({required this.detailUseCase,required this.getAttendanceInfoUseCase,required this.getCurrentMonthDatesUseCase}) : super(HomeState(detailEntity: null,pageState: HomePageState.init,attendanceInfoEntity: null,dates: [],selectDay: DateFormat('yyyy-MM-dd').format(DateTime.now()))) {
    on<SelectDayEvent>(_selectDay);
    on<LoadingMonthAndDayInfoEvent>(_loadingMonthAndTodayInfo);

  }

  void _selectDay(SelectDayEvent event, Emitter<HomeState> emit)async{
    emit(state.copyWith(selectDay:event.day ));
    if(event.day !=DateTime.now().day) {
      emit(state.copyWith(pageState: HomePageState.loading));
      var response1 = await detailUseCase(
          params: GetAttendanceDetailParams(id: event.dayId));

      response1.fold((left) {
        CustomToast.fireToast(left.message ?? "");
      }, (data) {
        emit(state.copyWith(
            detailEntity: data, pageState: HomePageState.success));
      });
    }

  }


  void _loadingMonthAndTodayInfo(LoadingMonthAndDayInfoEvent event, Emitter<HomeState> emit)async{
    emit(state.copyWith(pageState: HomePageState.loading));
    var response1 = await getCurrentMonthDatesUseCase();
    var response2 = await getAttendanceInfoUseCase();

    response1.fold(
            (left){CustomToast.fireToast(left.message??"");},
            (data){ emit(state.copyWith(dates: data));});

    response2.fold(
            (left){CustomToast.fireToast(left.message??"");},
            (data){emit(state.copyWith(attendanceInfoEntity: data,pageState: HomePageState.success));});
  }




}
