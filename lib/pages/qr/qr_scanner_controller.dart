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

  void onQRViewCreated(QRViewController controllerQRView2) {
    controllerQRView = controllerQRView2;
    controllerQRView.resumeCamera();
    controllerQRView.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && scanData.code != null) {
        await onCheckQRCode(scanData.code!, 0);
      }
    });
  }

  Future onCheckQRCode(String qrcode, int parkingID) async {
    try {
      EasyLoading.show();
      controllerQRView.pauseCamera();
      var response = await HttpClientLocal().postCheckQRCode(qrcode, parkingID);
      var result = BookingInsertModel.getBookingInsertResponse(response.data);
      if (result.message == null) {
        Get.toNamed("/charging", arguments: result.data);
      } else {
        EasyLoading.showError("QR Code invalid");
      }
    } catch (e) {
      EasyLoading.showError("fail_again".tr);
    } finally {
      controllerQRView.resumeCamera();
      EasyLoading.dismiss();
    }
  }

  Future onInsertBooking() async {}
}
