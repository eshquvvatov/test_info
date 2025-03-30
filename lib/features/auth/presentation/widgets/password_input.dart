
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
typedef ValidatorFunction = String? Function(String?);
typedef PasswordFunction = void Function(String phone);
class CustomPasswordInput extends StatefulWidget {
  const CustomPasswordInput({super.key,required this.onChange,required this.validator});
  final PasswordFunction onChange;
  final ValidatorFunction validator;
  @override
  State<CustomPasswordInput> createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool isShow = false;
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 48.h,maxHeight: 80.h),
      child: TextFormField(
        validator: widget.validator,
        onChanged: widget.onChange,
        keyboardType: TextInputType.text,
        obscureText: isShow,
        obscuringCharacter: "*",
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "Password",

            contentPadding: EdgeInsets.only(top: 0.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: Colors.grey, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: Colors.black, width: 1.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: Colors.red, width: 1.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: Colors.red, width: 1.w),
            ),
            prefixIcon:Icon(Icons.lock),
            suffixIcon: InkWell(onTap: (){
              setState(() {
                isShow = !isShow;
              });
            },child: Icon(isShow?CupertinoIcons.eye_slash:CupertinoIcons.eye))

        ),
      ),
    );
  }
}
