import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../model/charge_car.dart';
import '../profile/dark_mode_page.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class HomeController extends GetxController {
  RxList<Marker> lstMarkLocaltion = RxList([]);
  Rx<ChargeCarModel?> markLocaltionCurrent = Rx<ChargeCarModel?>(null);
  final Rx<PanelController> pageController =
      Rx<PanelController>(PanelController());
  final Rx<MapController> mapController = Rx<MapController>(MapController());

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();

    for (var element in ChargeCarModel.getList()) {
      lstMarkLocaltion.add(Marker(
        width: 32,
        height: 32,
        point: element.latLng!,
        builder: (ctx) => InkWell(
          child: Image.asset("assets/icons/icon_charging.png"),
          onTap: () {
            mapController.value
                .move(element.latLng!, 15, id: DateTime.now().toString());
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
  }

  void moveLocation(ChargeCarModel model) {
    mapController.value.move(model.latLng!, 17);
    markLocaltionCurrent.value = model;
    pageController.value.open();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // change dark mode
  var listDarkMode = [
    DarkModeModel("Light", ThemeMode.light),
    DarkModeModel("Dark", ThemeMode.dark)
  ].obs;

  changeDarkMode(ThemeMode theme) {
      Get.changeThemeMode(theme);
      Get.back();
  }
}
