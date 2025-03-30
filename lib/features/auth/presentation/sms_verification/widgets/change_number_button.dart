
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
typedef ChangePhone = void Function();

class ChangePhoneNumber extends StatelessWidget {
  final ChangePhone onTap;
  const ChangePhoneNumber({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.blue.withOpacity(0.1),
        highlightColor: Colors.blue.withOpacity(0.2),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width:1.0,
              ),
            ),
          ),
          child: Text(
            'Change number!',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight:  FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
