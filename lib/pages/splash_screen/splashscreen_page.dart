import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/services/model/booking_detail.dart';
import 'package:charge_car/services/model/home.dart';
import 'package:charge_car/services/model/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<bool?> getNotification(int page) async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getListNotification(page);
      homeModel.listNotification =
          NotificationModel.getListNotificationResponse(response.data);
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

  Future<bool?> getListBookingDetail() async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getListBookingDetail(-100, 1);
      homeModel.listBookingDetail =
          BookingDetail.getListBookingDetailResponse(response.data);
      return true;
    } catch (e) {
      return null;
    }
  }

  Future onInitLoading() async {
    var response = await Future.wait([
      getProfile(),
      getListParking(),
      getNotification(1),
      getListBookingDetail()
    ]);

    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.photos,
      Permission.notification,
    ].request();
    if(statuses.values.firstWhere((element) => element == PermissionStatus.denied, orElse: () => PermissionStatus.granted) == PermissionStatus.denied){
      openAppSettings();
    }

    if (!response.contains(null)) {
      Get.offAndToNamed(LocalDB.getUserID == 0 ? "/login" : "/", arguments: homeModel);
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
