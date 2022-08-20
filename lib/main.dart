import 'package:charge_car/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';

import 'pages/splashscreen_page.dart';
import 'theme/theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.grey[200],
    systemNavigationBarIconBrightness: Brightness.dark,
    // systemNavigationBarDividerColor: Colors.black,
  ));
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Style.dark,
      debugShowCheckedModeBanner: false,
      home: const SplashScreenPage(),
      initialBinding: HomeBinding(),
    );
  }
}
