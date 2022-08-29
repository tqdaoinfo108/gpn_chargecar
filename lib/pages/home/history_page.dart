import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

import '../../services/model/booking_detail.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage(this.controller, {Key? key}) : super(key: key);
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Paddings.normal),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("History",
                style: theme.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: Space.medium),
            (controller.homeData.value.listBookingDetail == null ||
                    controller.homeData.value.listBookingDetail!.data!.isEmpty)
                ? Expanded(
                    child: Center(
                        child: Text(
                    "No data found",
                    style: theme.textTheme.bodyLarge,
                  )))
                : SingleChildScrollView(
                    child: Column(children: [
                      for (var item in controller
                              .homeData.value.listBookingDetail?.data ??
                          [])
                        itemNotification(context, item),
                    ]),
                  ),
          ]),
        ),
      ),
    );
  }

  InkWell itemNotification(context, BookingDetail data) {
    return InkWell(
      onTap: () {},
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
                "${data.dateStart}-${data.dateEnd}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Text(
                "Số Kwh: ${data.powerConsumption ?? 0}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Text(
                "Tổng tiền: ${data.amount ?? 0}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  data.dateBook.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Color(0xff67727d).withOpacity(0.6)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
