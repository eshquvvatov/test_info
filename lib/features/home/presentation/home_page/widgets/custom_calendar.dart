import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/month_date_entity.dart';
import '../bloc/home_bloc.dart';

class CustomCalendar extends StatefulWidget {
  final List<MonthDateEntity> monthDays;
  const CustomCalendar({super.key, required this.monthDays});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late final ScrollController _scrollController;
  late String selectedDate;

  late int initialIndex;
  late String today ;
  @override
  void initState() {
    super.initState();

     today  = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _scrollController = ScrollController();
  }


  @override
  void didUpdateWidget(covariant CustomCalendar oldWidget) {
    initialIndex = widget.monthDays.indexWhere((el)=>today==el.date);
    print(initialIndex);
    print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    if(widget.monthDays != oldWidget.monthDays) {
      isStart = false;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      final double itemWidth = 85.w;
       double offset = (itemWidth * (index-1));
      if (offset > _scrollController.position.maxScrollExtent) {
        offset = _scrollController.position.maxScrollExtent;
      }

      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  bool isStart = false;
  @override
  Widget build(BuildContext context) {
    print(widget.monthDays.toString());
    var bloc = context.read<HomeBloc>();
    selectedDate = bloc.state.selectDay;
    var sortedDates = widget.monthDays;
    var child = Container(
      height: 110.h,
      // constraints: BoxConstraints(minHeight: 70.h, maxHeight: 90.h),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          final date = sortedDates[index];
          final isToday = date.date == today;
          final isSelected = date.date == selectedDate;

          return GestureDetector(
            onTap: () {
              bloc.add(SelectDayEvent(day: date.date, dayId: sortedDates[index].id));
            },
            child: SizedBox(
              width: 85.w,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isToday ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown, // Kontentni chegaraga moslashtiradi
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 80.h, // Marginlarni hisobga olgan holda
                      maxHeight: 90.h, // Max chegarani qattiq belgilaymiz
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          _getEngWeekday(DateTime.parse(date.date)),
                          style: GoogleFonts.lato(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: isToday ? Colors.white : Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: isToday ? Colors.white : Colors.transparent,
                          ),
                          child: Text(
                            "${DateTime.parse(date.date).day}",
                            style: GoogleFonts.lato(
                              color: isToday ? Colors.green : const Color(0xFF1F1F1F),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "${date.monthName.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                            color: isToday ? Colors.white : const Color(0xFF1F1F1F),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    if (!isStart) {
      Future.delayed(Duration(seconds: 1),(){
      if(!isStart ){
        _scrollToIndex(initialIndex);
        isStart=true;
      }
    });
    }

    return child;
  }

  String _getEngWeekday(DateTime date) {
    final weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return weekdays[date.weekday % 7];
  }

  bool _isSameDate(String a, String b) {
    return a==b;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}