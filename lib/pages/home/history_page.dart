import 'package:charge_car/constants/index.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Paddings.normal),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("History",
                style: theme.textTheme.headline5!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: Space.medium),
            itemNotification(
                context,
                "GPN Charge car",
                "27/09/2022 16:33 --> 27/09/2022 16:33",
                "3kwh",
                "368.000 đ",
                "27/09/2022 16:33"),
            itemNotification(
                context,
                "Stop charging",
                "27/09/2022 16:33 --> 27/09/2022 16:33",
                "3kwh",
                "368.000 đ",
                "27/09/2022 16:33"),
            itemNotification(
                context,
                "Verified account",
                "27/09/2022 16:33 --> 27/09/2022 16:33",
                "3kwh",
                "368.000 đ",
                "27/09/2022 16:33"),
          ]),
        ),
      ),
    );
  }

  InkWell itemNotification(context, title, timetotime, kwh,totalMoney , dateTime) {
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
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Space.medium),
              Text(
                timetotime,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Text(
                "Số Kwh: $kwh",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
               Text(
                "Tổng tiền: $totalMoney",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: Space.small),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  dateTime,
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