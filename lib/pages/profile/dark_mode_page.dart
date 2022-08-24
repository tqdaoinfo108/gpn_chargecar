import 'package:charge_car/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../third_library/bottom_sheet_default.dart';

class DarkModeModel {
  String title;
  ThemeMode themeMode;
  DarkModeModel(this.title, this.themeMode);
}

final HomeController controller = Get.put(HomeController());

// ignore: must_be_immutable
class DarkModePage extends StatelessWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetDefault(
      title: "Dark mode",
      body: Column(
        children: [
          InkWell(
            onTap: () =>
                controller.changeDarkMode(controller.listDarkMode[0].themeMode),
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: Text(
                controller.listDarkMode[0].title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: !Get.isDarkMode
                  ? const Icon(Icons.check, size: 28, color: Colors.green)
                  : const SizedBox(),
            ),
          ),
          Divider(thickness: 0.5, color: Colors.grey.withOpacity(0.1)),
          InkWell(
            onTap: () =>
                controller.changeDarkMode(controller.listDarkMode[1].themeMode),
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: Text(controller.listDarkMode[1].title,
                  style: Theme.of(context).textTheme.bodyText1),
              trailing: Get.isDarkMode
                  ? const Icon(Icons.check, size: 28, color: Colors.green)
                  : const SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
