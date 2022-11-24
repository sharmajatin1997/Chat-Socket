import 'package:chat_socket/Utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Get.toNamed(Routes.chatListScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: Get.width,
              child: Center(
                  child: Image.asset(
                "assets/app_icon.png",
                fit: BoxFit.cover,
                width: Get.width,
              ))),
          Text(
            "Chat Socket",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
