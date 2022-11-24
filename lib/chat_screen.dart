import 'package:chat_socket/MessageModel.dart';
import 'package:chat_socket/UserModel.dart';
import 'package:chat_socket/Utils/api_constants.dart';
import 'package:chat_socket/helper_widget/app_text.dart';
import 'package:chat_socket/helper_widget/my_text_filed_.dart';
import 'package:chat_socket/socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatScreen extends StatelessWidget {
  final UserModel user2Model;

  ChatScreen({Key? key, required this.user2Model}) : super(key: key) {
    if (user2Model.userid == ApiConstants.MY_USER_ID) {
      socketController.getMyChatList(user2Model.user2Id!);
    } else {
      socketController.getMyChatList(user2Model.userid!);
    }
  }

  final sendMessageController = TextEditingController();
  final socketController = Get.put(SocketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            socketController.getChatList();
          },
          child: Icon(
            Icons.arrow_left,
            color: Colors.white,
            size: 30.h,
          ),
        ),
        title: AppText(
          text: user2Model.name ?? user2Model.group_name ?? "",
          fontWeight: FontWeight.w600,
          color: Colors.white,
          textSize: 18.sp,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Expanded(
                child: ListView.builder(
                    reverse: true,
                    itemCount: socketController.myChatList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (socketController.myChatList[index].senderID ==
                              ApiConstants.MY_USER_ID)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: BubbleSpecialTwo(
                                text: socketController
                                        .myChatList[index].message ??
                                    "",
                                isSender: true,
                                sent: true,
                                // delivered:
                                //     socketController.isDeliver.value == true
                                //         ? true
                                //         : false,
                                color: Colors.blue.shade500,
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: BubbleSpecialOne(
                                text: socketController
                                        .myChatList[index].message ??
                                    "",
                                isSender: false,
                                color: Colors.grey.shade600,
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(5)),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyTextField(
                        text: "Send Message...",
                        controller: sendMessageController),
                  ),
                  GestureDetector(
                    onTap: () {
                      num user2Id;
                      if (user2Model.userid == ApiConstants.MY_USER_ID) {
                        user2Id = user2Model.user2Id!;
                      } else {
                        user2Id = user2Model.userid!;
                      }
                      MessageModel message = MessageModel(
                          userid: ApiConstants.MY_USER_ID,
                          user2Id: user2Id,
                          message: sendMessageController.text,
                          messageType: 0);
                      socketController.sendMessage(message);
                      sendMessageController.clear();
                      if (user2Model.userid == ApiConstants.MY_USER_ID) {
                        socketController.initMessageBody();
                      } else {
                        socketController.initMessageBody();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 5, top: 5, bottom: 5),
                      child: Image.asset(
                        "assets/send.png",
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
