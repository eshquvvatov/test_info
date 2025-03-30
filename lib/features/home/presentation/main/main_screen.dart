import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

import '../../../../core/detectLocation.dart';
import '../../../../core/di/service_locator.dart';
import '../../../setting/presentation/pages/setting_screen.dart';
import '../home_page/home_screen.dart';
import 'bloc/main_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  late final PageController controller;

  @override
  void initState() {

    controller = PageController(initialPage: sl<MainBloc>().state.currentPage);
    sl<MainBloc>().add(CheckInitEvent());

    super.initState();
  }

  Widget? checkInAndCheckOut(BuildContext context){
     Color? color;
     String? iconPath;
     VoidCallback? onTap;

    var data = context.read<MainBloc>().state;
    if (data.checkStatus == CheckStatus.checkIn){
      color = AppColors.GreenMain;
      iconPath = AppImages.income;
      onTap = (){
        LocationService.getCurrentLocation(context).then((value) async {
          if(value != null && context.mounted) {
            context.read<MainBloc>().add(CheckInEvent(
                lat: value.latitude.toString(),
                lon: value.longitude.toString()));
          }
        });
      };
    }
    else if(data.checkStatus == CheckStatus.checkOut){
      color = AppColors.RedMain;
      iconPath = AppImages.outcome;
      onTap = (){
        LocationService.getCurrentLocation(context).then((value) async {
          if(value != null && context.mounted) {
            context.read<MainBloc>().add(CheckOutEvent(
                lat: value.latitude.toString(),
                lon: value.longitude.toString()));
          }
        });
      };;
    }
    else{
      return null;
    }

    return FloatingActionButton(
      backgroundColor: color,
      onPressed: onTap,
      child:SvgPicture.asset(iconPath)
    );
  }

  @override
  Widget build(BuildContext context) {
    print(sl<MainBloc>().isClosed);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: false,
          toolbarHeight: 70.h,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.bell,color: Colors.black,size: 22.sp),
            ),
            SizedBox(width: 10.w),
            // Icon(icon)
          ],
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(width: 2.w),
              CircleAvatar(radius: 25.r, child: Image.asset(AppImages.avatar)),
              SizedBox(width: 15.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Komila Aliyeva',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0C0C0C),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.h,
                    ),
                  ),
                  Text(
                    'Head of UX Design',
                    style: GoogleFonts.lato(
                      color: const Color(0xFFB1B1B1),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
          backgroundColor: Colors.white,
          body: PageView(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            children: [
            const HomeScreen(),
            const SettingScreen()
          ],),
          floatingActionButton:BlocBuilder<MainBloc, MainState>(

            builder: (context,state) {
              return checkInAndCheckOut(context)??SizedBox();
            }
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BlocBuilder<MainBloc, MainState>(

            builder: (context, state) {
              return BottomNavigationBar(
                selectedItemColor: AppColors.GreenMain,
                elevation: 20.sp,
                backgroundColor: Colors.white,
                selectedIconTheme: IconThemeData(color: AppColors.GreenMain),
                type: BottomNavigationBarType.fixed,
                currentIndex: state.currentPage,
                onTap: (index)  {
                  context.read<MainBloc>().add(ChangeNavigationEvent(currentPage: index));
                  controller.jumpToPage(index);

                },
                items: [

                  BottomNavigationBarItem(

                    icon: SvgPicture.asset(
                      AppImages.homeicon,
                      color: state.currentPage == 0 ? AppColors.GreenMain : Colors.grey, // Shart bilan rang berish
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImages.settingsicon,
                      color: state.currentPage == 1 ? AppColors.GreenMain : Colors.grey, // Shart bilan rang berish
                    ),
                    label: 'Profile',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
