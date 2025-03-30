
import 'package:aros_staff/features/home/presentation/home_page/bloc/home_bloc.dart';
import 'package:aros_staff/features/home/presentation/home_page/widgets/custom_check_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';


class DayDetailInfo extends StatefulWidget {
  const DayDetailInfo({super.key});

  @override
  State<DayDetailInfo> createState() => _DayDetailInfoState();
}

class _DayDetailInfoState extends State<DayDetailInfo> {

  @override
  Widget build(BuildContext context) {
    var data = context.read<HomeBloc>().state.detailEntity;
    var value = data?.dailyResult??0.0;
    return  Container(
      color: Color(0XFFF8F9FA),
      padding: const EdgeInsets.all(16.0),
      child: Stack(

        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r),color: Color(0XFFF7F5F5)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Work Efficiency",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Positioned(
            top: 0,
            child: SizedBox(
              width: 200.w,
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 2000,
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 170,
                    endAngle: 10,
                    radiusFactor: 1.15,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 40,
                      cornerStyle: CornerStyle.bothCurve,

                      color: Color(0xFFEAEAEA), // Background arc color
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: value.toDouble(),
                        width: 40,
                        gradient: const SweepGradient(
                          colors: [Color(0xff5b81ff), Color(0xff645eff),Color(0xff6b42ff)],
                        ),
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.1,
                        angle: 180,
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${data?.dailyResult} / 100",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // const SizedBox(height: 5),
                            const Text(
                              "Daily result",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(

            top: 260.h,
            child: SizedBox(
              height: 69.h,
              width: 0.9.sw,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: CustomCheckContainer(text: 'Check-In', color: const Color(0xFF1FBA4A), imagePath: AppImages.income, time:"${data?.checkIn}")),
                  SizedBox(width: 10.w),
                  Expanded(child: CustomCheckContainer(text:  'Check-Out', color: AppColors.RedMain, imagePath: AppImages.income, time: '${data?.checkOut}',)),

                ],
              ),
            ),)
        ],
      ),
    );
  }
}
