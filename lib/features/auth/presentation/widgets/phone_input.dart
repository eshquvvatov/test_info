
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
typedef ValidatorFunction = String? Function(String?);
typedef PhoneFunction = void Function(String phone);

class CustomPhoneInput extends StatefulWidget {
  const CustomPhoneInput({super.key,required this.onChange,required this.validator});
  final PhoneFunction onChange;
  final ValidatorFunction validator;
  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  late final  TextEditingController controller;
  var maskFormatter =  MaskTextInputFormatter(mask: '+###-##-###-##-##', filter: { "#": RegExp(r'[0-9]') });
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      constraints: BoxConstraints(minHeight: 48.h,maxHeight: 80.h),
      child: TextFormField(
        controller: controller,
        validator: widget.validator,
        onChanged: widget.onChange,
        keyboardType: TextInputType.phone,
        inputFormatters: [maskFormatter],
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "+998 Telifon raqamingiz",
            contentPadding: EdgeInsets.only(top: 5.h),
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
          prefixIcon:Icon(Icons.phone)

        ),
      ),
    );
  }
}
