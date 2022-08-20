import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../third_library/button_default.dart';
import '../third_library/progress_button/iconed_button.dart';
import '../third_library/progress_button/progress_button.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Paddings.content),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform(
                  transform: Matrix4.translationValues(
                      MediaQuery.of(context).size.width * .3, -20.0, 0.0),
                  child: SvgPicture.asset('assets/svg/svg_splashscreen.svg',
                      width: 300)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Charge\nAnywhere",
                    style: theme.textTheme.headline4!.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: Space.superLarge),
                Text(
                    "Carcharge is peer-peer EV charging network that lets you access other electric vehicle owners chargers amd earn money be remtomg out yours",
                    style: theme.textTheme.bodyText1!.copyWith(
                        color: theme.colorScheme.primary,
                        fontSize: FontSizes.subtitle1,
                        fontWeight: FontWeight.normal)),
                const SizedBox(height: Space.superLarge),
                DefaultButton(
                    text: 'Get start',
                    textColor: theme.colorScheme.primary,
                    backgroundColor: theme.primaryColor,
                    press: () => Get.to(HomePage())),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
