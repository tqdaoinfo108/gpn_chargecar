import 'package:charge_car/services/model/booking_insert.dart';
import 'package:charge_car/services/servces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../services/model/booking_detail.dart';
import '../../services/mqtt_client.dart';
import '../../third_library/count_down/circular_countdown_timer.dart';

class ChargingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChargingPageController>(ChargingPageController());
  }
}

class ChargingModel {
  String title;
  bool isChoose;
  Duration duration;
  int value;

  ChargingModel(this.title, this.isChoose, this.duration, this.value);
}

class ChargingPageController extends GetxController {
  // late Rx<PieAnimationController?> countController = Rx(null);
  late Rx<CountDownController> countController = Rx(CountDownController());

  MqttClientLocal mqttClient = MqttClientLocal();

  var listChargingModel = [
    ChargingModel("1${'h'.tr}", false, const Duration(hours: 1), 1),
    ChargingModel("2${'h'.tr}", false, const Duration(hours: 2), 2),
    ChargingModel("3${'h'.tr}", false, const Duration(hours: 3), 3),
    ChargingModel("4${'h'.tr}", false, const Duration(hours: 4), 4),
    ChargingModel("5${'h'.tr}", false, const Duration(hours: 5), 5),
    ChargingModel("full".tr, true, const Duration(days: 999999), 0),
  ].obs;

  var duration =
      ChargingModel("full".tr, true, const Duration(days: 999), 0).obs;

  Rx<BookingInsertModel> bookingInsertModel = Rx(BookingInsertModel(
      chargingPostName: "", nameArea: "", powerSocketName: ""));

  late BookingDetail booking;
  var isShowStop = false.obs;

  var initialDuration = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    bookingInsertModel.value = Get.arguments;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (bookingInsertModel.value.timeStartWhenExist != 0) {
        for (var item in listChargingModel) {
          item.isChoose =
              item.value == bookingInsertModel.value.timeStopCharging!;
        }
        booking = BookingDetail(bookId: bookingInsertModel.value.bookingID);
        isShowStop.value = true;
        countController.value.isShow = true;
        initialDuration.value = DateTime.now().millisecondsSinceEpoch ~/ 1000 -
            bookingInsertModel.value.timeStartWhenExist!;
        duration.value = listChargingModel.firstWhere((element) =>
            element.value == (bookingInsertModel.value.timeStopCharging ?? 0));

        await mqttClient.init((p0) => onMQTTCalled(p0));
        mqttClient.client.subscribe(
            bookingInsertModel.value.topicName ?? "#", MqttQos.atLeastOnce);

        countController.value.start();
      }
    });
  }

  onChoose(ChargingModel choose) {
    for (var element in listChargingModel) {
      element.isChoose = false;
    }
    duration.value = choose;
    listChargingModel.firstWhere((p0) => p0 == choose).isChoose = true;
    listChargingModel.refresh();
  }

  Future insertQRCode() async {
    try {
      await mqttClient.init((p0) => onMQTTCalled(p0));
      mqttClient.client.subscribe(
          bookingInsertModel.value.topicName ?? "#", MqttQos.atLeastOnce);

      EasyLoading.show();
      var response = await HttpClientLocal().postInsertBooking(
          bookingInsertModel.value.qrCode ?? "",
          bookingInsertModel.value.parkingId ?? 0,
          duration.value.value);
      var result = BookingDetail.getBookingDetailResponse(response.data);
      if (result.message == null) {
        isShowStop.value = true;
        booking = result.data!;
        countController.value.isShow = true;
        countController.value.start();
      } else {
        EasyLoading.showError('qr_code_invalid'.tr);
      }
    } catch (e) {
      EasyLoading.showError('qr_code_invalid'.tr);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void onMQTTCalled(List<MqttReceivedMessage<MqttMessage>> c) async {
    final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    var arrPayload = pt.split(':');
    var arrTopic = c[0].topic.split('/');

    printInfo(info: "daotq: ------- $pt");
    if (arrPayload.length == 10 &&
        bookingInsertModel.value.areaIdMqtt == arrTopic[2] &&
        bookingInsertModel.value.charingPostIdMqtt == arrPayload[0]) {
      var arrChargingPost = List<String>.generate(
          arrPayload[1].length, (index) => arrPayload[1][index]);
      int? index =
          int.tryParse(bookingInsertModel.value.charingPostId_Child ?? "0");
      if (arrChargingPost[index! - 1] == "0") {
        mqttClient.client.disconnect();
        await Future.delayed(const Duration(seconds: 2));
        Get.back(result: {"page": "1"});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    mqttClient.client.disconnect();
  }

  Future onStopBooking() async {
    try {
      EasyLoading.show();

      var response = await HttpClientLocal().postBookingUpdate(booking.bookId!);
      var result = BookingInsertModel.getBookingInsertResponse(response.data);
      if (result.message == null) {
        EasyLoading.showSuccess("success".tr);
        countController.value.pause();
      } else {
        EasyLoading.showError("fail_again".tr);
      }
    } catch (e) {
      EasyLoading.showError("fail_again".tr);
    }
  }
}
