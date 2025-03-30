import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/router_names.dart';
import '../../../../core/constants/app_colors.dart';
typedef OnChangeCallback = void Function(bool checked);
class CustomCheckBox extends StatefulWidget {
  final  OnChangeCallback  onTap;
  const CustomCheckBox({super.key,required this.onTap});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;

  void selectBox(bool? checked){
    if (checked != null){
      setState(() {
        isChecked =checked;
        widget.onTap(isChecked);
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(value: isChecked, onChanged:selectBox,side: BorderSide(color: Colors.grey,width: 1.w,style: BorderStyle.solid,strokeAlign: 2),activeColor: AppColors.signInMainColor,materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,),
            const Text('Remember me')
          ],
        ),
        TextButton(onPressed: () {context.push(AppRoutesName.changePhoneNumber);},style: TextButton.styleFrom(
          textStyle: TextStyle(color: Colors.grey),
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ), child: const Text('Forgot Password?',style: TextStyle(color: Colors.grey),))
      ],
    );
  }
}
