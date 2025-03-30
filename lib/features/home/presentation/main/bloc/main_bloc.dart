
import 'package:aros_staff/core/utils/custom_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/check_state_entity.dart';
import '../../../domain/usecases/check_in_usecase.dart';
import '../../../domain/usecases/check_out_usecase.dart';
import '../../../domain/usecases/check_state_usecase.dart';
import '../../../domain/usecases/face_scan_usecase.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;
  final CheckStateUseCase checkStateUseCase;
  final FaceScanUseCase faceScanUseCase;

  MainBloc({ required this.checkInUseCase,  required this.checkOutUseCase, required this.checkStateUseCase, required this.faceScanUseCase}) : super(const MainState( pageState: PageState.init, checkStatus: CheckStatus.init, currentPage: 0))
  {
    on<ChangeNavigationEvent>(_onChangeNavigation);
    on<CheckInEvent>(_onCheckIn);
    on<CheckOutEvent>(_onCheckOut);
    on<CheckInitEvent>(_checkInitialState);



  }

  Future<void> _checkInitialState(CheckInitEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    final result = await checkStateUseCase();
    result.fold( (failure) => emit(state.copyWith( pageState: PageState.error, checkStatus: CheckStatus.init)),
          (CheckStateEntity entity) {

        final status = entity.isCheckedIn
            ? CheckStatus.checkIn
            : entity.isCheckedOut
            ? CheckStatus.completed
            : CheckStatus.init;
        emit(state.copyWith(
          pageState: PageState.success,
          checkStatus: status,
        ));
      },
    );
  }

  void _onChangeNavigation(ChangeNavigationEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(currentPage: event.currentPage));
  }

  void _onCheckIn(CheckInEvent event, Emitter<MainState> emit)async{
    var response = await checkInUseCase(params: CheckInParams(lat: event.lat, lon: event.lon));
    response.fold(
            (left){CustomToast.fireToast("${left.message}");},
            (right){CustomToast.fireToast("${right.message}"); add(CheckInitEvent());}
    );
  }
  void _onCheckOut(CheckOutEvent event, Emitter<MainState> emit)async{
    var response = await checkOutUseCase(params: CheckOutParams(lat: event.lat, lon: event.lon));
    response.fold(
            (left){CustomToast.fireToast("${left.message}");},
            (right){CustomToast.fireToast("${right.message}"); add(CheckInitEvent());}
    );
  }


}