import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../third_library/button_default.dart';
import '../../third_library/count_down/circular_countdown_timer.dart';
import 'charging_controller.dart';

class ChargingPage extends GetView<ChargingPageController> {
  const ChargingPage({Key? key}) : super(key: key);

  String interpolate(String string, List<String> params) {
    String result = string;
    for (int i = 1; i < params.length + 1; i++) {
      result = result.replaceAll('%${i}\$', params[i - 1]);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () async {
            EasyLoading.dismiss();
            controller.isStart = false;
            return !controller.isShowStop.value;
          },
          child: Scaffold(
              appBar: controller.isShowStop.value
                  ? null
                  : AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      iconTheme: IconThemeData(
                          color: Theme.of(context).colorScheme.primary),
                    ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Paddings.kDialogContentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (controller.isShowStop.value)
                        const SizedBox(height: Space.superLarge),
                      Text(
                          "${controller.bookingInsertModel.value.nameArea!} - ${controller.bookingInsertModel.value.chargingPostName!}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      Center(
                        child: CircularCountDownTimer(
                          duration:
                              controller.duration.value.duration.inSeconds,
                          initialDuration: controller.initialDuration.value,
                          controller: controller.countController.value,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2.3,
                          ringColor: Colors.grey[300]!,
                          ringGradient: null,
                          fillColor: Theme.of(context).primaryColor,
                          fillGradient: null,
                          backgroundColor: Theme.of(context).cardColor,
                          backgroundGradient: null,
                          strokeWidth: 20.0,
                          strokeCap: StrokeCap.round,
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                          textFormat: CountdownTextFormat.S,
                          isReverse: false,
                          isReverseAnimation: false,
                          isTimerTextShown: true,
                          autoStart: true,
                          onStart: () {},
                          onComplete: () {},
                          onChange: (String timeStamp) {},
                        ),
                      ),
                      if (controller.isShowStop.value)
                        Column(
                          children: [
                            Text('charging'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: Space.superLarge),
                          ],
                        ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: Space.medium,
                        runSpacing: Space.medium,
                        children: [
                          for (var item in controller.listChargingModel)
                            DefaultButtonWidthDynamic(
                              backgroundColor: item.isChoose
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                              widget: Text(item.title),
                              press: () async {
                                if (!controller.isShowStop.value) {
                                  controller.onChoose(item);
                                }
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: Space.large),
                      if (!controller.isShowStop.value)
                        Row(
                          children: [
                            Expanded(
                              child: DefaultButtonWidthDynamic(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                widget: Text(
                                  "cancel".tr,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                press: () async {
                                  Get.back();
                                },
                              ),
                            ),
                            const SizedBox(width: Space.large),
                            Expanded(
                              child: DefaultButtonWidthDynamic(
                                backgroundColor: Theme.of(context).primaryColor,
                                widget: Text(
                                  "start".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                ),
                                press: () async {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('notification'.tr),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(interpolate(
                                                  'charge_within'.tr, [
                                                controller.duration.value.title
                                              ])),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('no'.tr),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('yes'.tr),
                                            onPressed: () async {
                                              Get.back();
                                              await controller.insertQRCode();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      if (controller.isShowStop.value)
                        Row(
                          children: [
                            Expanded(
                              child: DefaultButtonWidthDynamic(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                widget: Text(
                                  "stop_charging".tr,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                press: () async {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('notification'.tr),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(
                                                'stop_charging'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('no'.tr),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('yes'.tr),
                                            onPressed: () async {
                                              Get.back();
                                              await controller.onStopBooking();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              )),
        ));
  }
}
