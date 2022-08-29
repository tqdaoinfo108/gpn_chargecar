import 'package:get/get.dart';

import '../../third_library/count_down/circular_countdown_timer.dart';

class ChargingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChargingPageController>(() => ChargingPageController());
  }
}

class ChargingModel {
  String title;
  bool isChoose;
  Duration duration;

  ChargingModel(this.title, this.isChoose, this.duration);
}

class ChargingPageController extends GetxController {
  final  countController = CountDownController().obs;
  var listChargingModel = [
    ChargingModel("1H", false, const Duration(hours: 1)),
    ChargingModel("2H", false, const Duration(hours: 2)),
    ChargingModel("3H", false, const Duration(hours: 3)),
    ChargingModel("4H", false, const Duration(hours: 4)),
    ChargingModel("5H", false, const Duration(hours: 5)),
    ChargingModel("FULL", true, const Duration(days: 9999)),
  ].obs;
  late var duration = ChargingModel("FULL", true, const Duration(hours: 999999)).obs;

  var isShowStop = false.obs;
  @override
  void onInit() {
    super.onInit();
    duration = listChargingModel.last.obs;
  }

  onChoose(ChargingModel choose) {
    listChargingModel.value.forEach((element) {element.isChoose = false;});
    listChargingModel.value.firstWhere((p0) => p0 == choose).isChoose = true;
    listChargingModel.refresh();
  }

  void onStartDuration(){
    countController.value.start();
    isShowStop.value =true;
  }
}
