import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  RxList<Marker> lstMarkLocaltion = RxList([
    Marker(
      width: 80,
      height: 80,
      point: LatLng(10.780231, 106.6645121),
      builder: (ctx) => const FlutterLogo(
        textColor: Colors.blue,
        key: ObjectKey(Colors.blue),
      ),
    )
  ]);

  final Rx<PanelController> pageController =
      Rx<PanelController>(PanelController());
  final Rx<MapController> mapController = Rx<MapController>(MapController());
  // Change page
  Rx<int> pageCurrent = Rx<int>(0);
  void onChangePageScreen(int pageNumber) {
    pageCurrent.value = pageNumber;
    print(pageNumber);
  }
}
