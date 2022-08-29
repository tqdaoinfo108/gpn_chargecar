import 'package:charge_car/third_library/scaffold_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'qr_scanner_controller.dart';

class QRScannerPage extends GetView<QRScannerPageController> {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      "",
      QRView(
        key: controller.qrKey,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
        ),
        onQRViewCreated: controller.onQRViewCreated,
      ),
    );
  }
}
