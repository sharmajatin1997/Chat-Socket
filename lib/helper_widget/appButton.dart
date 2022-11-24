import 'package:chat_socket/helper_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key? key,
      required this.title,
      this.onTap,
      this.height,
      this.width,
      this.textColor,
      this.borderColor,
      this.gradientColor1,
      this.gradientColor2})
      : super(key: key);
  String title;
  VoidCallback? onTap;
  double? height, width;
  Color? textColor, gradientColor1, gradientColor2,borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 45.h,
        width: width ?? Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.h),
            border: Border.all(color: borderColor??Colors.transparent),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientColor1 ?? Colors.red,
                gradientColor2 ?? Colors.deepOrangeAccent
              ],
            )),
        child: Center(
            child: AppText(
          text: title,
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.w700,
        )),
      ),
    );
  }
}
