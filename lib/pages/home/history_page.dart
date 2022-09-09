import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/model/booking_detail.dart';
import '../../utils/func.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage(this.controller2, {Key? key}) : super(key: key);
  final HomeController controller2;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final controller = Get.put(HomeController());

    return Obx(
      () => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(Paddings.normal),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("history".tr,
                  style: theme.textTheme.headline5!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: Space.medium),
              (controller.homeData.value.listBookingDetail == null ||
                      controller
                          .homeData.value.listBookingDetail!.data!.isEmpty)
                  ? Expanded(
                      child: Center(
                          child: Text(
                      'data_not_found'.tr,
                      style: theme.textTheme.bodyLarge,
                    )))
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          for (var item in controller
                                  .homeData.value.listBookingDetail?.data ??
                              [])
                            itemNotification(context, item),
                        ]),
                      ),
                    ),
            ]),
          ),
        ),
      ),
    );
  }

  GestureDetector itemNotification(context, BookingDetail data) {
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
                "${'total_amount'.tr}: ${data.amount ?? 0}",
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
}
