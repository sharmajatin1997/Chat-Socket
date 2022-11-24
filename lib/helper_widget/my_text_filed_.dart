import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  String text;
  TextEditingController? controller = TextEditingController();

  MyTextField({Key? key, required this.text, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(left:5.w,top: 5.h,bottom: 5.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.r))
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.h),
            border: InputBorder.none,
            //  prefixIcon:controller.isTextFiledFocus.value==true?Image.asset("assets/email_prefix_icon.png",scale: 3,): Image.asset("assets/email_prefix_icon_white.png",scale: 3,),
            // suffixIcon: ,
            hintText: text,
            hintStyle: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w500, fontSize: 14.sp)),
      ),

    );
  }
}
