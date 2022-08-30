import 'package:charge_car/constants/index.dart';
import 'package:charge_car/third_library/scaffold_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../third_library/button_default.dart';
import '../../third_library/count_down/circular_countdown_timer.dart';
import 'charging_controller.dart';

class ChargingPage extends GetView<ChargingPageController> {
  const ChargingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ScaffoldDefault(
        "",
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Paddings.kDialogContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircularCountDownTimer(
                  duration: controller.duration.value.duration.inSeconds,
                  initialDuration: 0,
                  controller: controller.countController.value,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
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
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: false,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: false,
                  onStart: () {},
                  onComplete: () {},
                  onChange: (String timeStamp) {},
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: Space.medium,
                runSpacing: Space.medium,
                children: [
                  for (var item in controller.listChargingModel.value)
                    DefaultButtonWidthDynamic(
                      backgroundColor: item.isChoose
                          ? Theme.of(context).primaryColor
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                      widget: Text(item.title),
                      press: () async {
                        controller.onChoose(item);
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
                          "Cancel",
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
                          "Start",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                        press: () async {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Notication'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Charge within ${controller.duration.value.title}?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      controller.onStartDuration();
                                      Get.back();
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
                          "Stop charging",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        press: () async {
                           showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Notication'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Stop charging'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      controller.countController.value.reset();
                                      Get.back();
                                      Get.back();
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
        )));
  }
}
