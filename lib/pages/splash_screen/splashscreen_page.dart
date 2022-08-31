import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/services/model/booking_detail.dart';
import 'package:charge_car/services/model/booking_insert.dart';
import 'package:charge_car/services/model/home.dart';
import 'package:charge_car/services/model/notification.dart';
import 'package:charge_car/third_library/button_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:latlong2/latlong.dart';

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
  LatLng latlng = LatLng(0, 0);
  bool isPermission = false;
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
      var response = await HttpClientLocal().getListChargeCarLocaltion(
          "", 1, 150,
          lat: latlng.latitude, lng: latlng.longitude);
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

  Future<BookingDetail?> checkBookingExist() async {
    if (LocalDB.getUserID == 0) return null;

    try {
      var response =
          await HttpClientLocal().getBookingExist(LocalDB.getUserID, 0);
      var booking = BookingDetail.getBookingDetailResponse(response.data);
      if (booking.message == null) {
        return booking.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future onInitLoading() async {
    // var isExist = await checkBookingExist();
    // if (isExist != null) {
    //   Get.offAllNamed("/charging",
    //       arguments: BookingInsertModel(
    //           bookingID: isExist.bookId,
    //           bookingStart: isExist.dateStart,
    //           duration: isExist.timeStopCharging));
    //   return;
    // }

    await [
      Permission.location,
      Permission.camera,
      // Permission.photos,
      // Permission.notification
    ].request();

    var isLocation = await Permission.location.request().isGranted;
    var isCamera = await Permission.camera.request().isGranted;

    if (!isLocation || !isCamera) {
      setState(() {
        isPermission = true;
      });
      return;
    }

    try {
      var locationData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latlng = LatLng(locationData.latitude, locationData.longitude);
      // ignore: empty_catches
    } catch (e) {}

    if (LocalDB.getUserID == 0) {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAndToNamed("/login");
      return;
    }

    loadingIntoHome();
  }

  Future<bool> loadingIntoHome() async {
    setState(() {
      isPermission = false;
    });
    var response = await Future.wait([
      getProfile(),
      getListParking(),
      getNotification(1),
      getListBookingDetail()
    ]);

    if (!response.contains(null)) {
      Get.offAllNamed(LocalDB.getUserID == 0 ? "/login" : "/",
          arguments: homeModel);
      return true;
    }
    return false;
  }

  Future<bool> isCheckPermisstion() async {
    var isLocation = await Permission.location.request().isGranted;
    var isCamera = await Permission.camera.request().isGranted;
    if (isLocation && isCamera) {
      var locationData = await Geolocator.getCurrentPosition();
      latlng = LatLng(locationData.latitude, locationData.longitude);
      loadingIntoHome();
      return true;
    } else {
      await openAppSettings();
      return false;
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
                isPermission
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultButton(
                            text: "open_settings".tr,
                            backgroundColor: theme.primaryColor,
                            textColor: Colors.white,
                            press: () async {
                              isCheckPermisstion();
                            },
                          ),
                          const SizedBox(height: Space.medium),
                          Text("grant_location_and_camera".tr,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.subtitle2!
                                  .copyWith(color: theme.dividerColor)),
                          const SizedBox(height: Space.medium),
                          GestureDetector(
                            onTap: () => loadingIntoHome(),
                            child: Padding(
                              padding: const EdgeInsets.all(Space.small),
                              child: Text(
                                "Skip",
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
