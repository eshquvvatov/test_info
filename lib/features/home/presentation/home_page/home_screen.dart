import 'package:aros_staff/features/home/presentation/home_page/widgets/custom_calendar.dart';
import 'package:aros_staff/features/home/presentation/home_page/widgets/custom_today_info.dart';
import 'package:aros_staff/features/home/presentation/home_page/widgets/day_detail_info.dart';
import 'package:aros_staff/features/home/presentation/widgets/custom_loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/service_locator.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late HomeBloc bloc ;
  @override
  void initState() {
    bloc = HomeBloc(detailUseCase: sl(), getAttendanceInfoUseCase: sl(), getCurrentMonthDatesUseCase: sl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => bloc..add(LoadingMonthAndDayInfoEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final bool isLoading = state.pageState == HomePageState.loading;

            return CustomLoadingContainer(
              color: Colors.transparent,
              isLoading: isLoading,
              child: Column(
                children: [
                  CustomCalendar(monthDays: state.dates),
                  SizedBox(height: 10.h),
                  Expanded(
                      child: state.selectDay ==  DateFormat('yyyy-MM-dd').format(DateTime.now())
                          ? CustomTodayInfo()
                          : DayDetailInfo())
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
