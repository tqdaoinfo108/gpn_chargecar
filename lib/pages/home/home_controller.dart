// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:charge_car/services/model/home.dart';
import 'package:charge_car/services/model/parking.dart';
import 'package:charge_car/services/model/response_base.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/model/booking_detail.dart';
import '../../services/model/notification.dart';
import '../../services/servces.dart';
import 'profile/dark_mode_page.dart';
import 'package:latlong2/latlong.dart';

import 'profile/language_page.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class HomeController extends GetxController {
  RxList<Marker> lstMarkLocaltion = RxList([]);

  Rx<ParkingModel?> markLocaltionCurrent = Rx<ParkingModel?>(null);
  final Rx<PanelController> pageController =
      Rx<PanelController>(PanelController());

  final Rx<MapController> mapController = Rx<MapController>(MapController());

  RxDouble sizeHeightPopup = RxDouble(0);

  Rx<HomeModel> homeData = HomeModel().obs;

  var isOpenCall = false.obs;

  var fabHeight = 20.0.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Get.arguments != null) {
        if (Get.arguments['type'] == 1) {
          homeData.value = Get.arguments['data'];
        } else if (Get.arguments['type'] == 2) {
          homeData.value = Get.arguments['homeData'];

          var result =
              await Get.toNamed("/charging", arguments: Get.arguments['data']);
          if (result != null) {
            EasyLoading.show();
            onChangePageScreen(int.parse(result["page"]!));
            await getListBookingDetail();
            EasyLoading.dismiss();
          }
        }
      }
      homeData.refresh();
    });

    init();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      isOpenCall.value = result;
    });
  }

  Future<LatLng> getLocation() async {
    var isLocation = await Permission.location.request().isGranted;
    if (isLocation) {
      try {
        var locationData = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);
        return LatLng(locationData.latitude, locationData.longitude);
      } catch (e) {
        return LatLng(homeData.value.listParking![0].latParking!,
            homeData.value.listParking![0].ingParking!);
      }
    }
    return LatLng(homeData.value.listParking![0].latParking!,
        homeData.value.listParking![0].ingParking!);
  }

  init() async {
    try {
      var latlng = await getLocation();
      mapController.value.move(latlng, 15);
      lstMarkLocaltion.add(Marker(
          width: 32,
          height: 32,
          point: latlng,
          builder: (ctx) => InkWell(
                child: Image.asset("assets/icons/ic_current.png"),
                onTap: () {
                  mapController.value
                      .move(latlng, 15, id: DateTime.now().toString());
                },
              )));
      // ignore: prefer_const_constructors
      // final LocationSettings locationSettings = LocationSettings(
      //   accuracy: LocationAccuracy.medium,
      //   distanceFilter: 60,
      // );

      //   Geolocator.getPositionStream(locationSettings: locationSettings)
      //       .listen((Position? position) {
      //     var latlng = LatLng(position?.latitude ?? 0, position?.longitude ?? 0);
      //     lstMarkLocaltion[0] = Marker(
      //         width: 32,
      //         height: 32,
      //         point: latlng,
      //         builder: (ctx) => InkWell(
      //             child: Image.asset("assets/icons/ic_current.png"),
      //             onTap: () {
      //               mapController.value
      //                   .move(latlng, 15, id: DateTime.now().toString());
      //             }));
      //   });
    } catch (e) {}

    for (var element in homeData.value.listParking ?? []) {
      lstMarkLocaltion.add(Marker(
        width: 36,
        height: 36,
        point: element.getLatLng,
        builder: (ctx) => InkWell(
          child: Image.asset("assets/icons/icon_charging.png"),
          onTap: () {
            mapController.value
                .move(element.getLatLng, 15, id: DateTime.now().toString());
            markLocaltionCurrent.value = element;
            pageController.value.open();
          },
        ),
      ));
    }
  }

  // Change page
  Rx<int> pageCurrent = Rx<int>(0);
  void onChangePageScreen(int pageNumber) {
    pageCurrent.value = pageNumber;

    if (pageNumber == 0) {
      mapController.value = MapController();
    } else if (pageNumber == 1) {
      getListBookingDetail();
    } else if (pageNumber == 2) {
      getListNotifition();
    }
  }

  void moveLocation(ParkingModel model) {
    try {
      mapController.value.move(model.getLatLng, 17);
      markLocaltionCurrent.value = model;
      pageController.value.open();
    } catch (e) {
      mapController.value.state =
          MapState(GetMapOption, (a) {}, mapController.value.mapEventSink);
      mapController.value.move(model.getLatLng, 17);
      markLocaltionCurrent.value = model;
      pageController.value.open();
    }
  }

  MapOptions get GetMapOption {
    return MapOptions(
        keepAlive: true,
        center: lstMarkLocaltion.isNotEmpty
            ? lstMarkLocaltion[0].point
            : LatLng(1, 1),
        onTap: (tapPosition, point) {
          pageController.value.close();
        },
        onLongPress: (tapPosition, point) {
          pageController.value.close();
        },
        onPositionChanged: ((position, hasGesture) {
          pageController.value.close();
        }),
        zoom: 15,
        maxZoom: 17,
        minZoom: 4);
  }

  // change dark mode
  var listDarkMode = [
    DarkModeModel("system".tr, ThemeMode.system, "system"),
    DarkModeModel("light".tr, ThemeMode.light, "light"),
    DarkModeModel("dark".tr, ThemeMode.dark, "dark")
  ].obs;

  changeDarkMode(ThemeMode theme) {
    LocalDB.setThemeMode =
        listDarkMode.firstWhere((element) => element.themeMode == theme).code;
    listDarkMode.refresh();
    Get.changeThemeMode(theme);
    Get.back();
  }

  // change Language
  RxList<LocaleModel> lstLanguage = [
    LocaleModel("English", const Locale('en')),
    LocaleModel("日本語", const Locale('jp'))
  ].obs;

  changeLanguage(Locale locale) {
    LocalDB.setLanguageCode = locale.languageCode;
    Get.updateLocale(locale);
    Get.back();
  }

  onLogout() async {
    try {
      EasyLoading.show();
      var response =
          await HttpClientLocal().postDeleteAccount(LocalDB.getUserID);
      var isDelete = ResponseBase.fromJson(response.data);
      if (isDelete.data) {
        LocalDB.setUserID = 0;
        Get.offAllNamed("/splash");
      } else {
        EasyLoading.showError("fail_again".tr);
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
  }

  // get history
  Future<bool?> getListBookingDetail({int page = 1}) async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getListBookingDetail(-100, page);
      if (page == 1) {
        homeData.value.listBookingDetail!.data!.clear();
      }
      var rawReponse =
          BookingDetail.getListBookingDetailResponse(response.data);
      homeData.value.listBookingDetail!.data!.addAll(rawReponse.data!);
      homeData.value.listBookingDetail!.page = page + 1;
      homeData.value.listBookingDetail!.totals = rawReponse.totals;
      homeData.value.listBookingDetail!.data!.refresh();
      homeData.refresh();
      update();
      return true;
    } catch (e) {
      return null;
    }
  }

  // get list notification
  Future<bool> getListNotifition({int page = 1}) async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getListNotification(page);
      if (page == 1) {
        homeData.value.listNotification!.data!.clear();
      }
      var rawResponse =
          NotificationModel.getListNotificationResponse(response.data);

      homeData.value.listNotification!.data!.addAll(rawResponse.data!);
      homeData.value.listNotification!.page = page + 1;
      homeData.value.listNotification!.totals = rawResponse.totals;
      homeData.value.listNotification!.data!.refresh();
      homeData.refresh();
      update();
      return true;
    } catch (e) {
      return false;
    }
  }
}
