import 'dart:io';
import 'package:chat_socket/Utils/colors.dart';
import 'package:chat_socket/Utils/helper/socket_helper.dart';
import 'package:chat_socket/Utils/route_generator.dart';
import 'package:chat_socket/Utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Utils/shared_prefrence_helper.dart';
import 'Utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SharedPreferenceHelper.init();
  await SocketHelper().init();
  String initialRoute = await findInitialRoute();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.grey, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp(initialRoute)));
  configLoading();
}

Future<String> findInitialRoute() async {
  String initialRoute = Routes.splash;
  /* Tuple2? tuple2 = await NotificationService().getPushNotificationRoute();
  if(tuple2!=null){
    args = tuple2.item2;
    initialRoute = tuple2.item1;
  }*/
  return initialRoute;
}

Object? args;

class MyApp extends StatelessWidget {
  late String initialRoute;

  MyApp(
    this.initialRoute, {
    super.key,
  });

  static startFirstScreen(String? message) {
    // SharedPreferenceHelper().clearAll();
    SocketHelper().disconnectUser();
    Get.offAllNamed(Routes.splash);
    Utils.errorSnackBar(message);
    // Utils.hideLoader();
  }

  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              navigatorKey: Get.key,
              builder: EasyLoading.init(
                  builder: (BuildContext? context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context!);
                final scale = data.textScaleFactor.clamp(1.0, 1.3);
                return MediaQuery(
                  data: data.copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              }),
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: "Montserrat",
                bannerTheme: const MaterialBannerThemeData(
                    backgroundColor: Colors.black),
              ),
              debugShowCheckedModeBanner: false,
              navigatorObservers: [ClearFocusOnPush()],
              initialRoute: Routes.splash,
              onGenerateRoute: RoutesGenerator.generateRoute,
              onGenerateInitialRoutes: (String initialRouteName) {
                return [
                  RoutesGenerator.generateRoute(
                      RouteSettings(name: initialRoute, arguments: args))
                ];
              });
        });
  }
}

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.white
    ..backgroundColor = AppColors.greenColor
    ..indicatorColor = AppColors.white
    ..textColor = AppColors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
