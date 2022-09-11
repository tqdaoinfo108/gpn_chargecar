import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/splash_screen/splashscreen_controller.dart';
import 'package:charge_car/third_library/button_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Obx(
      () => Scaffold(
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
                    child: Image.asset('assets/images/svg_splashscreen.png',
                        width: 250)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("EvStand\n充電システム",
                      style: theme.textTheme.headline4!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: Space.superLarge),
                  Text("splash_screen_message".tr,
                      style: theme.textTheme.bodyText1!.copyWith(
                          color: theme.colorScheme.primary,
                          fontSize: FontSizes.subtitle1,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(height: Space.superLarge),
                  const SizedBox(height: Space.superLarge),
                  controller.isRetry.value
                      ? DefaultButton(
                          text: "retry".tr,
                          backgroundColor: theme.primaryColor,
                          textColor: Colors.white,
                          press: () async {
                            await controller.loadingIntoHome();
                          },
                        )
                      : !controller.isPermission.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultButton(
                                  text: "open_settings".tr,
                                  backgroundColor: theme.primaryColor,
                                  textColor: Colors.white,
                                  press: () async {
                                    var response = await openAppSettings();
                                    if (response) {
                                      controller.loadingIntoHome();
                                    }
                                  },
                                ),
                                const SizedBox(height: Space.medium),
                                Text("grant_location_and_camera".tr,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.subtitle2!
                                        .copyWith(color: theme.dividerColor)),
                                const SizedBox(height: Space.medium),
                                GestureDetector(
                                  onTap: () =>
                                      controller.loadingIntoHome(isSkip: true),
                                  child: Padding(
                                    padding: const EdgeInsets.all(Space.small),
                                    child: Text(
                                      "skip".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.blue),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const CupertinoActivityIndicator(
                                  radius: RadiusSize.cardBorderRadius,
                                ),
                              ],
                            ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
