import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSettingCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData leadingIcon;
  final Widget trialingIcon;
  const CustomSettingCard({this.onTap ,super.key,required this.leadingIcon,required this.title,required this.trialingIcon});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 8.h,horizontal: 16.w),
        color: Color(0XFFFAFAFA),
        child: SizedBox(height: 56.h,child: Row(children: [
          Container(height: 40.h,width: 40.w,
            margin: EdgeInsets.only(left: 16.w,right: 16.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color: Colors.white),
            child: Icon(leadingIcon),),
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp)),
          Spacer(),
          trialingIcon,
          SizedBox(width: 16.w,)
        ],),),
      ),
    );
  }
}
