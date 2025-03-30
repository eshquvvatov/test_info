import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  final VoidCallback? onTap;



  const CustomAppBar({super.key,
    required this.titleText,
    this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.only(top: 0),
        child: AppBar(
          backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            leading: IconButton(onPressed: onTap??(){context.pop();}, icon: Icon(Icons.arrow_back_ios_new)),
            title:  Text(titleText,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
            iconTheme: IconThemeData( color: Colors.black),
            centerTitle: true,
            elevation: 0,

        ),
      ),
    );
  }

  @override
  Size get preferredSize =>Size(1.sw,75.h);

}