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
                context, 1, "Starting to charge", "27/09/2022 16:33"),
            itemNotification(context, 2, "Stop charging", "27/09/2022 16:33"),
            itemNotification(
                context, 3, "Verified account", "27/09/2022 16:33"),
          ]),
        ),
      ),
    );
  }

  InkWell itemNotification(context, id, title, dateTime) {
    return InkWell(
      onTap: () {},
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
              SizedBox(
                width: 100,
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
                        getImage(id),
                        const SizedBox(height: Space.superSmall),
                        Text(getString(id))
                      ]),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          dateTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: Color(0xff67727d).withOpacity(0.6)),
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
      return "Charging";
    } else if (id == 2) {
      return "Stop charging";
    } else if (id == 3) {
      return "Verified";
    } else {
      return "";
    }
  }
}
