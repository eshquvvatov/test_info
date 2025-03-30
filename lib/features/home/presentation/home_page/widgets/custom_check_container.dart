import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/custom_animation.dart';

class CustomCheckContainer extends StatelessWidget {
  final String text;
  final String time;
  final Color color;
  final String imagePath;
  const CustomCheckContainer({super.key,required this.text,required this.color,required this.imagePath,required this.time});

  @override
  Widget build(BuildContext context) {
    return CustomAnimationsSlide(
      direction: FadeSlideDirection.btt,
      duration: 0.4,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.r),color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              text,
              style: TextStyle(
                color: const Color(0xFF7E7E7E),
                fontSize: 12,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              time,
              style: TextStyle(
                color: const Color(0xFF1F1F1F),
                fontSize: 18,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w700,
              ),
            )
          ],),

          Container(
            width: 34.w,
            height: 34.h,
            decoration: ShapeDecoration(
              color:color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: SvgPicture.asset(imagePath),
                ),
              ],
            ),
          )
        ],),
      ),
    );
  }
}
