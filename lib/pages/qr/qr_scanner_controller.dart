import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRScannerPageController>(() => QRScannerPageController());
  }
}

class QRScannerPageController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controllerQRView;

  void onQRViewCreated(QRViewController controllerQRView) {
    controllerQRView = controllerQRView;
    controllerQRView.scannedDataStream.listen((scanData) {
     
    });
  }
}
