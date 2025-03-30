import 'package:aros_staff/core/utils/url_louncher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../domain/entities/support_entity.dart';
import '../widgets/custom_app_bar.dart';

class Support extends StatelessWidget {
  final SupportEntity? data;
  const Support({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(titleText: "Help & Support"),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical:16.h),
            child: Column(
              children: [
                SupportCard(onTap: (){CustomUrlLauncher.urlEmailLauncher(mail: data?.email??"");}, imagePath: AppImages.mail, name: "${data?.email}"),
                SupportCard(onTap: (){CustomUrlLauncher.urlTelLauncher(phone: data?.phoneNumber??"");}, imagePath: AppImages.phone, name: "${data?.phoneNumber}"),
                SupportCard(onTap: (){CustomUrlLauncher.urlTelegramLauncher(telegramUrl: data?.telegram??"");}, imagePath: AppImages.telegramIcon, name: "${data?.telegram}"),
                SupportCard(onTap: (){CustomUrlLauncher.urlTelegramLauncher(telegramUrl: data?.address??"");}, imagePath: AppImages.telegramIcon, name: "${data?.address}"),
              ],),
          ),
        ),
      ),
    );
  }
}


class SupportCard extends StatelessWidget {

  final String imagePath;
  final String name;
  final VoidCallback onTap;
  const SupportCard({super.key,required this.onTap,required this.imagePath,required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 62.h,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Color(0xFFFAFAFA),
        ),
        child: Row(
          children: [
            Container(height: 30.h,width: 30.w,decoration:BoxDecoration(shape: BoxShape.circle),child:SvgPicture.asset(imagePath)),
            SizedBox(width: 16.w),
            Text(name,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),),

          ],
        ),
      ),
    );
  }
}



