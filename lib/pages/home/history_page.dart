import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

import '../../services/model/booking_detail.dart';
import '../../utils/func.dart';

Widget historyPage(BuildContext context, HomeController controller) {
  var theme = Theme.of(context);
  final controller = Get.put(HomeController());

  GestureDetector itemHistory(context, BookingDetail data) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Paddings.minimum),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(RadiusSize.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.05),
                spreadRadius: 2,
                blurRadius: 7,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(Paddings.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.nameParking ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Space.medium),
              Text(
                data.addressParking ?? "",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Text(
                "${data.nameArea} - ${data.chargingPostName} - ${data.charingPostIdMqtt}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Text(
                "${Functions.getDateTimeString(data.dateStart)} - ${Functions.getDateTimeString(data.dateEnd)}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Text(
                "${'number_kwh'.tr}: ${data.powerConsumption ?? 0}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Text(
                "${'total_amount'.tr}: ${data.amountString}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  Functions.getDateTimeString(data.createdDate),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: const Color(0xff67727d).withOpacity(0.6)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Obx(
    () => Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(
                top: Paddings.normal,
                right: Paddings.normal,
                left: Paddings.normal),
            child: Text("history".tr,
                style: theme.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: Space.medium),
          (controller.homeData.value.listBookingDetail == null ||
                  controller.homeData.value.listBookingDetail!.data!.isEmpty)
              ? Expanded(
                  child: Center(
                      child: Text(
                  'data_not_found'.tr,
                  style: theme.textTheme.bodyLarge,
                )))
              : Expanded(
                  child: LoadMore(
                    textBuilder: (status) => "",
                    isFinish: controller
                            .homeData.value.listBookingDetail!.data!.length >=
                        controller.homeData.value.listBookingDetail!.totals!,
                    onLoadMore: () async => await controller.getListNotifition(
                        page:
                            controller.homeData.value.listBookingDetail!.page!),
                    child: ListView.builder(
                      itemCount: controller
                          .homeData.value.listBookingDetail!.data!.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Paddings.normal),
                          child: itemHistory(
                              context,
                              controller.homeData.value.listBookingDetail!
                                  .data![index]),
                        );
                      }),
                    ),
                  ),
                ),
        ]),
      ),
    ),
  );
}
