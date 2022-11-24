import 'dart:collection';
import 'package:chat_socket/ChatModel.dart';
import 'package:chat_socket/MessageModel.dart';
import 'package:chat_socket/Utils/api_constants.dart';
import 'package:chat_socket/Utils/helper/socket_helper.dart';
import 'package:chat_socket/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketController extends GetxController {
  late Socket _socketIO;
  SocketHelper socketHelper = SocketHelper();
  String tag = "socket";
  var showLoader = false.obs;
  RxList<ChatModel> chatList = RxList();
  RxList<MessageModel> myChatList = RxList();
  int groupId = 0;
  // var isDeliver = false.obs;

  @override
  void onInit() {
    _socketIO = socketHelper.getSocket();
    if (socketHelper.isConnected && socketHelper.isUserConnected) {
      getChatList();
    }
    super.onInit();
  }

  Future getChatList() async {
    if (await Utils.hasNetwork()) {
      _socketIO.on(ApiConstants.INBOX_LISTENER, (data) {
        print("$tag getChatList response ${data.toString()}");
        showLoader.value = false;
        chatList.clear();
        List<dynamic> list = data;
        for (var element in list) {
          chatList.add(ChatModel.fromJson(element as Map<String, dynamic>));
        }
      });
      chatList.value.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      chatList.refresh();
      // isDeliver.value = true;
      _socketIO.emit(
          ApiConstants.INBOX_EMITTER, {"userid": ApiConstants.MY_USER_ID});
    }
    print("$tag inbox chat hit");

  }

  Future getMyChatList(num id) async {
    if (await Utils.hasNetwork()) {
      _socketIO.off(ApiConstants.ONE_TO_ONE_LISTENER);
      _socketIO.on(ApiConstants.ONE_TO_ONE_LISTENER, (data) {
        print("$tag myChatList response ${data.toString()}");
        showLoader.value = false;
        myChatList.clear();
        List<dynamic> list = data;
        for (var element in list) {
          myChatList
              .add(MessageModel.fromJson(element as Map<String, dynamic>));
          myChatList.value
              .sort((a, b) => b.created_at!.compareTo(a.created_at!));
          myChatList.refresh();
        }
      });
      myChatList.refresh();
      Map<String, dynamic> map = HashMap();
      map["userid"] = ApiConstants.MY_USER_ID;
      if (groupId > 0) {
        map["group_id"] = groupId;
        map['group_type'] = 1;
      } else {
        map["user2Id"] = id;
      }
      _socketIO.emit(ApiConstants.ONE_TO_ONE_EMITTER, map);
      print("get message called $map");
    }
    // isDeliver.value = false;
  }

  Future sendMessage(MessageModel model) async {
    if (await Utils.hasNetwork()) {
      _socketIO.off(ApiConstants.SEND_MSG_LISTENER);
      _socketIO.on(ApiConstants.SEND_MSG_LISTENER, (data) {
        print("$tag sendMessage response ${data.toString()}");
        showLoader.value = false;
      });
      addMessage(model);
      _socketIO.emit(ApiConstants.SEND_MSG_EMITTER, model);
    }
    // isDeliver.value = false;
  }

  Future initMessageBody() async {
    if (await Utils.hasNetwork()) {
      _socketIO.on(ApiConstants.SEND_MSG_LISTENER, (data) {
        print("$tag bodyMessage response ${data.toString()}");
        getChatList();
        var model = MessageModel.fromJson(data);
        if (model.senderID != ApiConstants.MY_USER_ID) {
          addMessage(model);
        }
      });
    }
    // isDeliver.value = false;
  }

  void addMessage(MessageModel message) {
    if (message.userid == ApiConstants.MY_USER_ID) {
      message.senderID = message.userid;
    } else {
      message.senderID = message.user2Id;
    }
    myChatList.insert(0, message);
    myChatList.refresh();
    debugPrint("$tag add message ${message.toJson().toString()}");
  }

}
