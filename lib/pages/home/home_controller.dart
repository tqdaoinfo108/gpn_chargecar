import 'dart:async';

import 'package:charge_car/services/model/home.dart';
import 'package:charge_car/services/model/parking.dart';
import 'package:charge_car/services/model/response_base.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/model/booking_detail.dart';
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

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      homeData.value = Get.arguments;
    }
    homeData.refresh();
    init();
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      isOpenCall.value = result;
    });
  }

  init() async {
    try {
      var locationData = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      var latlng = LatLng(locationData.latitude, locationData.longitude);
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
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 60,
      );

      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
        var latlng = LatLng(position?.latitude ?? 0, position?.longitude ?? 0);
        lstMarkLocaltion[0] = Marker(
            width: 32,
            height: 32,
            point: latlng,
            builder: (ctx) => InkWell(
                child: Image.asset("assets/icons/ic_current.png"),
                onTap: () {
                  mapController.value
                      .move(latlng, 15, id: DateTime.now().toString());
                }));
      });
    } catch (e) {}

    for (var element in homeData.value.listParking ?? []) {
      lstMarkLocaltion.add(Marker(
        width: 32,
        height: 32,
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
    }
  }

  void moveLocation(ParkingModel model) {
    mapController.value.move(model.getLatLng, 17);
    markLocaltionCurrent.value = model;
    pageController.value.open();
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
  Future<bool?> getListBookingDetail() async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getListBookingDetail(-100, 1);
      homeData.value.listBookingDetail = ResponseBase(data: RxList(
          BookingDetail.getListBookingDetailResponse(response.data).data!));
      homeData.value.listBookingDetail!.data!.refresh();
      homeData.refresh();
      update();
      return true;
    } catch (e) {
      return null;
    }
  }
}
