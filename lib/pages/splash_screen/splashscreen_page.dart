import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/services/model/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../services/model/parking.dart';
import '../../services/model/user.dart';
import '../../services/servces.dart';
import '../../utils/get_storage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  HomeModel homeModel = HomeModel();

  // PROFILE PAGE
  Future<bool?> getProfile() async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getProfile(LocalDB.getUserID);
      homeModel.userModel = UserModel.getUserResponse(response.data).data;
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> getListParking() async {
    try {
      var response =
          await HttpClientLocal().getListChargeCarLocaltion("", 1, 1000);
      homeModel.listParking =
          ParkingModel.getListParkingResponse(response.data).data;
      return true;
    } catch (e) {
      return null;
    }
  }

  Future onInitLoading() async {
    var response = await Future.wait([getProfile(), getListParking()]);
    if (!response.contains(null)) {
      Get.offAndToNamed("/", arguments: homeModel);
    }
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    onInitLoading();
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
                  child: Image.asset('assets/images/svg_splashscreen.png',
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
                const SizedBox(height: Space.superLarge),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CupertinoActivityIndicator(
                      radius: RadiusSize.cardBorderRadius,
                    ),
                  ],
                ),
                // DefaultButton(
                //     text: 'Get start',
                //     textColor: theme.colorScheme.primary,
                //     backgroundColor: theme.primaryColor,
                //     press: () => Get.to(HomePage())),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
