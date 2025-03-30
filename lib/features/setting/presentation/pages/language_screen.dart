import 'package:aros_staff/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_app_bar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(titleText: "Language"),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical:16.h),
            child: Column(
              children: [
              LanguageCard(onTap: (){}, imagePath: AppImages.uz, name: "Uzbek", isSelect: true),
              LanguageCard(onTap: (){}, imagePath: AppImages.ru, name: "Russian", isSelect: false),
              LanguageCard(onTap: (){}, imagePath: AppImages.eng, name: "English", isSelect: false),
            ],),
          ),
        ),
      ),
    );
  }
}


class LanguageCard extends StatelessWidget {
  final bool isSelect;
  final String imagePath;
  final String name;
  final VoidCallback onTap;
  const LanguageCard({super.key,required this.onTap,required this.imagePath,required this.name,required this.isSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isSelect?Color(0xFF1FBA4A).withOpacity(0.08):Color(0xFFFAFAFA),
          border: Border.all(width: 1.sp,color:isSelect?Color(0xFF1FBA4A).withOpacity(0.8):Color(0xFFD9D9D9))
      ),
      child: Row(
        children: [
          Container(height: 30.h,width: 30.w,decoration:BoxDecoration(shape: BoxShape.circle),child:Image.asset(imagePath,fit: BoxFit.cover)),
          SizedBox(width: 16.w),
          Text(name,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),),
          Spacer(),
          isSelect?Icon(Icons.check,color: Colors.black):SizedBox.shrink()
        ],
      ),
    );
  }
}

