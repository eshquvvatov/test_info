import 'package:aros_staff/features/home/presentation/home_page/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../widgets/custom_animation.dart';
import 'custom_container.dart';

class CustomTodayInfo extends StatelessWidget {
  const CustomTodayInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var data = context.read<HomeBloc>().state.attendanceInfoEntity;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),color: Color(0XFFF8F9FA)),
      child: GridView(
        padding: EdgeInsets.symmetric(
            horizontal: 10.w, vertical: 10.h),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.8,
        ),
        children: [
          CustomAnimationsSlide(
            direction: FadeSlideDirection.btt,
            duration: 0.4,
            child: CustomContainer(
              time: '${data?.attendance.checkIn}:',
              status: 'Checked In',
              icon: Container(
                width: 20.w,
                height: 20.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: SvgPicture.asset(AppImages.income,color: Colors.black),
              ),
            ),
          ),
          CustomAnimationsSlide(
            direction: FadeSlideDirection.btt,
            duration: 0.4,
            child: CustomContainer(
              time: '${data?.attendance.checkOut}',
              status: 'Checked Out',
              icon: Container(
                width: 20.w,
                height: 20.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: SvgPicture.asset(AppImages.outcome,color: Colors.black),
              ),
            ),
          ),
          CustomAnimationsSlide(
            direction: FadeSlideDirection.btt,
            duration: 0.4,
            child: CustomContainer(
              time: '${data?.stat.on}',
              status: 'On Time',
              icon: Container(
                width: 20.w,
                height: 20.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: SvgPicture.asset(AppImages.check,color: Colors.black),
              ),
            ),
          ),
          CustomAnimationsSlide(
            direction: FadeSlideDirection.btt,
            duration: 0.4,
            child: CustomContainer(
              time: '24 days',
              status: 'Total Attendance',

              icon: Icon(CupertinoIcons.calendar_today, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
