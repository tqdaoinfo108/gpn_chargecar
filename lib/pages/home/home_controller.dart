import 'package:charge_car/services/model/home.dart';
import 'package:charge_car/services/model/parking.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'profile/dark_mode_page.dart';
import 'package:latlong2/latlong.dart';

import 'profile/language_page.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
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

  @override
  void onInit() {
    super.onInit();
    homeData.value = Get.arguments;

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
      if (markLocaltionCurrent.value != null) {
        // mapController.value.move(markLocaltionCurrent.value!.latLng!, 15,
        //     id: DateTime.now().toString());
      }
    }
  }

  void moveLocation(ParkingModel model) {
    mapController.value.move(model.getLatLng, 17);
    markLocaltionCurrent.value = model;
    pageController.value.open();
  }

  // change dark mode
  var listDarkMode = [
    DarkModeModel("System", ThemeMode.system, "system"),
    DarkModeModel("Light", ThemeMode.light,"light"),
    DarkModeModel("Dark", ThemeMode.dark, "dark")
  ].obs;

  changeDarkMode(ThemeMode theme) {
    LocalDB.setThemeMode = listDarkMode.firstWhere((element) => element.themeMode == theme).code;
    Get.changeThemeMode(theme);
    Get.back();
  }

  // change Language
  RxList<LocaleModel> lstLanguage = [
    LocaleModel("English", const Locale('en')),
    LocaleModel("Japan", const Locale('jp'))
  ].obs;

  changeLanguage(Locale locale) {
    LocalDB.setLanguageCode = locale.languageCode;
    Get.updateLocale(locale);
    Get.back();
  }
}
