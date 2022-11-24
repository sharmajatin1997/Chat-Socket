import 'package:chat_socket/UserModel.dart';
import 'package:chat_socket/Utils/routes.dart';
import 'package:chat_socket/chat_list.dart';
import 'package:chat_socket/chat_screen.dart';
import 'package:chat_socket/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        widgetScreen = SplashScreen();
        break;
      case Routes.chatListScreen:
        widgetScreen = ChatListScreen();
        break;
      case Routes.chatScreen:
        widgetScreen = ChatScreen(user2Model: args as UserModel);
        break;

      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name,
        page: () => widgetScreen,
        transition: Transition.native,
        settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
