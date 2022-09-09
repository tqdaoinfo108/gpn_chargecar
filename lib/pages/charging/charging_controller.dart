import 'package:charge_car/pages/home/profile/language_page.dart';
import 'package:charge_car/services/model/booking_insert.dart';
import 'package:charge_car/services/servces.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../services/model/booking_detail.dart';
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
  var countController = CountDownController().obs;

  var listChargingModel = [
    ChargingModel("1${'h'.tr}", false, const Duration(hours: 1), 1),
    ChargingModel("2${'h'.tr}", false, const Duration(hours: 2), 2),
    ChargingModel("3${'h'.tr}", false, const Duration(hours: 3), 3),
    ChargingModel("4${'h'.tr}", false, const Duration(hours: 4), 4),
    ChargingModel("5${'h'.tr}", false, const Duration(hours: 5), 5),
    ChargingModel("full".tr, true, const Duration(days: 9999), 0),
  ].obs;

  var duration =
      ChargingModel("full".tr, true, const Duration(hours: 999999), 0).obs;

  Rx<BookingInsertModel> bookingInsertModel = Rx(BookingInsertModel(
      chargingPostName: "", nameArea: "", powerSocketName: ""));

  late BookingDetail booking;
  var isShowStop = false.obs;

  var initialDuration = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    duration = listChargingModel.last.obs;
    bookingInsertModel.value = Get.arguments;

    if (bookingInsertModel.value.qrCode == null) {
      initialDuration.value = DateTime.now().millisecondsSinceEpoch ~/ 1000 -
          bookingInsertModel.value.bookingStart!;
      duration.value = listChargingModel.firstWhere((element) =>
          element.value == (bookingInsertModel.value.timeStopCharging ?? 0));
      countController.value.start();
      isShowStop.value = true;
      booking = BookingDetail(bookId: bookingInsertModel.value.bookingID);
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
      var response = await HttpClientLocal().postInsertBooking(
          bookingInsertModel.value.qrCode ?? "",
          bookingInsertModel.value.parkingId ?? 0,
          duration.value.value);
      var result = BookingDetail.getBookingDetailResponse(response.data);
      if (result.message == null) {
        booking = result.data!;
        update();
        isShowStop.value = true;
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

  Future onStopBooking() async {
    try {
      EasyLoading.show();
      var response = await HttpClientLocal().postBookingUpdate(booking.bookId!);
      var result = BookingInsertModel.getBookingInsertResponse(response.data);
      if (result.message == null) {
        Get.back(result: {"page": "1"});
        EasyLoading.showSuccess("success".tr);
      } else {
        EasyLoading.showError("fail_again".tr);
      }
    } catch (e) {
      EasyLoading.showError("fail_again".tr);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
