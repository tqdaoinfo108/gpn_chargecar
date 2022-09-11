import 'package:charge_car/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

import '../../services/model/notification.dart';
import '../../utils/func.dart';
import 'home_controller.dart';

Widget notificationPage(BuildContext context, HomeController controller) {
  var theme = Theme.of(context);
  final controller = Get.put(HomeController());

  Image getImage(int id) {
    if (id == 1) {
      return Image.asset("assets/icons/charging.png", width: 42);
    } else if (id == 2) {
      return Image.asset("assets/icons/low_battery.png", width: 42);
    } else if (id == 3) {
      return Image.asset("assets/icons/email_verified.png", width: 42);
    } else {
      return Image.asset("assets/icons/charging.png", width: 42);
    }
  }

  String getString(id) {
    if (id == 1) {
      return 'charging'.tr;
    } else if (id == 2) {
      return 'stop_charging'.tr;
    } else if (id == 3) {
      return "Verified";
    } else {
      return "";
    }
  }

  GestureDetector itemNotification(context, NotificationModel data) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.05),
                  spreadRadius: 6,
                  blurRadius: 1,
                ),
              ]),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(RadiusSize.popupMenuBorderRadius),
                        bottomLeft:
                            Radius.circular(RadiusSize.popupMenuBorderRadius)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ionicons.document_text_outline
                        getImage(data.typeId!),
                        const SizedBox(height: Space.superSmall),
                        Text(
                          getString(data.typeId!),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 11),
                        )
                      ]),
                ),
              ),
              Container(
                width: Get.width / 1.5,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        data.title ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          Functions.getDateTimeString(data.createdDate),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: const Color(0xff67727d).withOpacity(0.6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Scaffold(
    backgroundColor: theme.scaffoldBackgroundColor,
    body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(
              top: Paddings.normal,
              right: Paddings.normal,
              left: Paddings.normal),
          child: Text("notification".tr,
              style: theme.textTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: Space.medium),
        if (controller.homeData.value.listNotification == null ||
            controller.homeData.value.listNotification!.data!.isEmpty)
          Expanded(
              child: Center(
                  child: Text(
            'data_not_found'.tr,
            style: theme.textTheme.bodyLarge,
          )))
        else
          Expanded(
            child: LoadMore(
              textBuilder: (status) => "",
              isFinish:
                  controller.homeData.value.listNotification!.data!.length >=
                      controller.homeData.value.listNotification!.totals!,
              onLoadMore: () async => await controller.getListNotifition(
                  page: controller.homeData.value.listNotification!.page!),
              child: ListView.builder(
                itemCount:
                    controller.homeData.value.listNotification!.data!.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Paddings.normal),
                    child: itemNotification(
                        context,
                        controller
                            .homeData.value.listNotification!.data![index]),
                  );
                }),
              ),
            ),
          ),
      ]),
    ),
  );
}
                      // 
