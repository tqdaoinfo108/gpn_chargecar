import 'package:charge_car/services/model/booking_insert.dart';
import 'package:charge_car/services/servces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../services/model/booking_detail.dart';
import '../../services/mqtt_client.dart';
import '../../third_library/count_down/circular_countdown_timer.dart';
import '../../utils/get_storage.dart';

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

class ChargingPageController extends GetxController
    with WidgetsBindingObserver {
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
  bool isInnerPage = true;
  bool isStart = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state = $state');
    if (state == AppLifecycleState.resumed) {
      onLoadDetail();
    }
  }

  Future<void> checkBookingExist() async {
    if (LocalDB.getUserID == 0) return;

    try {
      var response =
          await HttpClientLocal().getBookingExist(LocalDB.getUserID, 0);
      var booking = BookingInsertModel.getBookingInsertResponse(response.data);
      if (booking.message == null) {
        bookingInsertModel.value = booking.data!;
      } else {
        Get.back(result: {"page": "1"});
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future onLoadDetail() async {
    await checkBookingExist();
    initialDuration.value = bookingInsertModel.value.timeStartWhenExist!;
    initialDuration.refresh();
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    bookingInsertModel.value = Get.arguments;
    isInnerPage = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (bookingInsertModel.value.timeStartWhenExist != 0) {
        for (var item in listChargingModel) {
          item.isChoose =
              item.value == bookingInsertModel.value.timeStopCharging!;
        }
        booking = BookingDetail(bookId: bookingInsertModel.value.bookingID);
        isShowStop.value = true;
        countController.value.isShow = true;
        initialDuration.value = bookingInsertModel.value.timeStartWhenExist!;
        duration.value = listChargingModel.firstWhere((element) =>
            element.value == (bookingInsertModel.value.timeStopCharging ?? 0));

        await mqttClient.init((p0) => onMQTTCalled(p0), (() async {
          await onCheckBookingExits();
        }));
        mqttClient.client.subscribe(
            bookingInsertModel.value.topicName ?? "#", MqttQos.atLeastOnce);

        countController.value.start();
      }
    });
  }

  Future onCheckBookingExits() async {
    if (LocalDB.getUserID == 0) return;

    try {
      await HttpClientLocal().getListBookingDetail(-100, 1);
    } catch (e) {
      mqttClient.client.disconnect();
      isInnerPage = false;
      Get.back(result: {"page": "1"});
      return;
    }
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
      EasyLoading.show();

      await mqttClient.init((p0) => onMQTTCalled(p0), () async {
        await onCheckBookingExits();
      });
      mqttClient.client.subscribe(
          bookingInsertModel.value.topicName ?? "#", MqttQos.atLeastOnce);

      var response = await HttpClientLocal().postInsertBooking(
          bookingInsertModel.value.qrCode ?? "",
          bookingInsertModel.value.parkingId ?? 0,
          duration.value.value);
      var result = BookingDetail.getBookingDetailResponse(response.data);
      if (result.message == null) {
        // isShowStop.value = true;
        booking = result.data!;
        await Future.delayed(const Duration(seconds: 25));
        if (!isStart) {
          EasyLoading.showToast('unable_to_connect'.tr);
          Get.back();
        }
        // countController.value.isShow = true;
        // countController.value.start();
      } else {
        EasyLoading.showToast('qr_code_invalid'.tr);
      }
    } catch (e) {
      EasyLoading.showToast('unable_to_connect'.tr);
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
        bookingInsertModel.value.charingPostIdMqtt == arrPayload[0] &&
        isInnerPage) {
      var arrChargingPost = List<String>.generate(
          arrPayload[1].length, (index) => arrPayload[1][index]);
      int? index = int.tryParse(bookingInsertModel.value.charingPostId_Child!);
      if (arrChargingPost[index! - 1] == "0") {
        mqttClient.client.disconnect();
        isInnerPage = false;
        isStart = false;
        await Future.delayed(const Duration(seconds: 1));
        Get.back(result: {"page": "1"});
      } else if (arrChargingPost[index - 1] == "1") {
        if (!isStart) {
          isStart = true;
          isShowStop.value = true;
          countController.value.isShow = true;
          countController.value.start();
          EasyLoading.dismiss();
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    isInnerPage = false;
    isStart = false;
    mqttClient.client.disconnect();
    EasyLoading.dismiss();
  }

  Future onStopBooking() async {
    try {
      EasyLoading.show();
      // ignore: unrelated_type_equality_checks
      mqttClient.client.updates!
          .listen((List<MqttReceivedMessage<MqttMessage>> c) async {
        onMQTTCalled(c);
      });
      var response = await HttpClientLocal().postBookingUpdate(booking.bookId!);
      var result = BookingInsertModel.getBookingInsertResponse(response.data);
      if (result.message == null && result.data != null) {
        EasyLoading.showSuccess("success".tr);
        countController.value.pause();
      } else {
        EasyLoading.showError("fail_again".tr);
      }
    } catch (e) {
      EasyLoading.showError('unable_to_connect'.tr);
    }
  }
}
