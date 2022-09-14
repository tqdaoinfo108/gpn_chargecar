import 'package:charge_car/services/model/booking_insert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../services/servces.dart';

class QRScannerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRScannerPageController>(() => QRScannerPageController());
  }
}

class QRScannerPageController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  late QRViewController controllerQRView;
  int parkingID = 0;

  @override
  void onInit() {
    super.onInit();
    parkingID = Get.arguments["parkingID"] ?? "0";
  }

  void onQRViewCreated(QRViewController controllerQRView2) {
    controllerQRView = controllerQRView2;
    controllerQRView.resumeCamera();
    controllerQRView.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code != "") {
        await onCheckQRCode(scanData.code!, parkingID);
        controllerQRView.resumeCamera();
      }
      return;
    });
  }

  Future onCheckQRCode(String qrcode, int parkingID) async {
    try {
      EasyLoading.show();
      controllerQRView.pauseCamera();
      var response = await HttpClientLocal().postCheckQRCode(qrcode, parkingID);
      var result = BookingInsertModel.getBookingInsertResponse(response.data);
      if (result.message == null) {
        result.data?.qrCode = qrcode;
        Get.back(result: result.data);
      } else {
        EasyLoading.showError('qr_code_invalid'.tr);
      }
    } catch (e) {
      EasyLoading.showError('qr_code_invalid'.tr);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
