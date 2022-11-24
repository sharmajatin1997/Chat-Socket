import 'package:chat_socket/UserModel.dart';
import 'package:chat_socket/Utils/routes.dart';
import 'package:chat_socket/helper_widget/app_text.dart';
import 'package:chat_socket/socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({Key? key}) : super(key: key){
    socketController.initMessageBody();
    socketController.getChatList();
  }

  final socketController = Get.put(SocketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.arrow_left,
            color: Colors.white,
            size: 30.h,
          ),
        ),
        title: AppText(
          text: 'Messages',
          color: Colors.white,
          fontWeight: FontWeight.w600,
          textSize: 18.sp,
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: socketController.chatList.length,
            itemBuilder: (context, index) {
              String image;
              // if (socketController.chatList[index].userImage != null) {
              //   image = ApiConstants.imageBaseUrl +
              //       socketController.chatList[index].userImage!;
              // } else {
              image = "assets/user.png";
              // }

              return GestureDetector(
                onTap: () {
                  UserModel model=UserModel();
                  model.name=socketController.chatList[index].name;
                  model.group_name=socketController.chatList[index].groupName;
                  model.user2Id=socketController.chatList[index].user2id;
                  model.userid=socketController.chatList[index].userid;
                  Get.toNamed(Routes.chatScreen,arguments: model);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.blue)),
                  margin: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                                child: Image.asset(
                              image,
                              height: 40.h,
                              width: 40.w,
                              fit: BoxFit.cover,
                            )),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: AppText(
                                text: socketController.chatList[index].name ??
                                    socketController
                                        .chatList[index].groupName ??
                                    "",
                                textSize: 16.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        /**  Message Count Show if needed*/
                        if (socketController.chatList[index].unreadcount !=
                                null &&
                            socketController.chatList[index].unreadcount != 0)
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                              child: AppText(
                                text:
                                    "${socketController.chatList[index].unreadcount}",
                                color: Colors.white,
                              )),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
