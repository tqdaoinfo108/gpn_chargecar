import 'package:charge_car/services/model/booking_insert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../services/servces.dart';

class QRScannerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<QRScannerPageController>(QRScannerPageController());
  }
}

class QRScannerPageController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  int parkingID = 0;
  bool isBack = true;
  bool isCheck = true;
  MobileScannerController controller = MobileScannerController(formats: [BarcodeFormat.qrCode]);

  @override
  void onInit() {
    super.onInit();
    parkingID = Get.arguments["parkingID"] ?? "0";
    isBack = true;
  }

  Future onQRViewCreated(Barcode barcode) async {
    if (isCheck) {
      isCheck = false;
      try {
        var isValue = await onCheckQRCode(barcode.rawValue!, parkingID);
        if (isValue == null) {
          await Future.delayed(const Duration(seconds: 1));
        } else {
          controller.stop();
          controller.dispose();
          Get.back(result: isValue);
        }
      } catch (e) {
        await Future.delayed(const Duration(seconds: 1));
      } finally {
        isCheck = true;
      }
    }
  }

  Future<BookingInsertModel?> onCheckQRCode(
      String qrcode, int parkingID) async {
    try {
      EasyLoading.show();
      var response = await HttpClientLocal().postCheckQRCode(qrcode, parkingID);
      var result = BookingInsertModel.getBookingInsertResponse(response.data);
      if (result.message == null) {
        if (isBack) {
          result.data?.qrCode = qrcode;
          isBack = false;
          return result.data;
        }
        return null;
      } else {
        EasyLoading.showError('qr_code_invalid'.tr);
        return null;
      }
    } catch (e) {
      EasyLoading.showError('qr_code_invalid'.tr);
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
