import 'package:charge_car/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimens.dart';

class BottomSheetDefault extends StatelessWidget {
  const BottomSheetDefault({Key? key, required this.title, required this.body})
      : super(key: key);
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(RadiusSize.kDialogCornerRadius),
                topRight: Radius.circular(RadiusSize.kDialogCornerRadius))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Space.small),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.2)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
              child: body,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 9),
          ],
        ),
      ),
    );
  }
}
