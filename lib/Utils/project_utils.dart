import 'package:chat_socket/Utils/AppString.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

class UtilsLiveDj{
  static errorSnackBar(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      AppString.appName,
      message,
      backgroundColor: Colors.blue,
      padding: EdgeInsets.only(left: 20.h, bottom: 10.h),
      margin: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
      borderRadius: 5.h,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      titleText: Text(
        AppString.appName,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            height: 1.6),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            height: 1.6),
      ),
    );
  }
  static String _extractText(String? message) {
    if (message == null) {
      return "";
    }
    if (message.length > 200) {
      return message.substring(0, 199);
    } else {
      return message;
    }
  }

  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  static hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String? getFileType(String path) {
    final mimeType = lookupMimeType(path);
    String? result = mimeType?.substring(0, mimeType.indexOf('/'));
    return result;
    // if(mimeType.startsWith("image/")){
    //   return "image";
    // }else if(mimeType.startsWith("video/")){
    //   return "video";
    // }else{
    //   return "application";
    // }
  }

  static Future<bool> hasNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      //Utils.showError("check your connection");
      return false;
    } else {
      return true;
    }
  }

  static String getFullName(String? firstName, String? lastName) {
    if (firstName != null && lastName != null) {
      return firstName + " " + lastName;
    } else if (firstName != null) {
      return firstName;
    } else {
      return "";
    }
  }

  static String maskCardNumber(String? cardNumber) {
    cardNumber = cardNumber!.replaceAll("", "");
    int var1 = 0;
    StringBuffer var2;
    for (var2 = StringBuffer(); var1 < cardNumber.length; ++var1) {
      if (var1 > cardNumber.length - 5) {
        var2.write(cardNumber[var1]);
      } else {
        var2.write("X");
      }
    }
    return var2.toString();
  }

  static String convertMeterToKilometer(double meter) {
    return removeDecimalZeroFormatTwo(meter * 0.001);
  }

  static String removeDecimalZeroFormatTwo(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static String removeDecimalZeroFormat(String? number) {
    if (number == null) return "0";
    var n = double.parse(number);
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static Color getJobStatusColor(String? status) {
    switch (status) {
      case "1":
        return Color(0xff83f571);
      case "2":
        return Color(0xfff09d59);
      case "3":
        return Color(0xffE9240F);
      case "4":
        return Color(0xff43B31D);
      case "5":
        return Color(0xffE9240F);
      default:
        return Color(0xffE9240F);
    }
  }

  static String getJobStatusText(String? status) {
    switch (status) {
      case "1":
        return "Requested";
      case "2":
        return "Ongoing"; //accepted
      case "3":
        return "Rejected";
      case "4":
        return "Completed";
      case "5":
        return "Cancelled";
      default:
        return 'Hello';
    }
  }

  static String dayget(int id) {
    if (id == 1) {
      return "Monday";
    } else if (id == 2) {
      return "Tuesday";
    } else if (id == 3) {
      return "Wednesday";
    } else if (id == 4) {
      return "Thursday";
    } else if (id == 5) {
      return "Friday";
    } else if (id == 6) {
      return "Saturday";
    } else if (id == 7) {
      return "Sunday";
    } else
      return "";
  }

}
