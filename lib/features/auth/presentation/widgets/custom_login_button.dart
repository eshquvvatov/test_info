import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
typedef ButtonCallback = void Function();
class CustomButton extends StatelessWidget {
  final ButtonCallback onTap;
  final bool isActive;
  const CustomButton({super.key,required this.isActive,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? AppColors.signInMainColor : AppColors.signInButtonDiactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: isActive ? onTap : null,
        child: Text(
          'Sign In',
          style: TextStyle(
            fontSize: 18,
            color: isActive ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}
