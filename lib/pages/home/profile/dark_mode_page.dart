import 'package:charge_car/pages/home/home_controller.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../third_library/bottom_sheet_default.dart';

class DarkModeModel {
  String title;
  ThemeMode themeMode;
  String code;
  DarkModeModel(this.title, this.themeMode,this.code);
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
          newMethod(context, controller.listDarkMode[0]),
          Divider(thickness: 0.5, color: Colors.grey.withOpacity(0.1)),
          newMethod(context, controller.listDarkMode[1]),
           Divider(thickness: 0.5, color: Colors.grey.withOpacity(0.1)),
          newMethod(context, controller.listDarkMode[2]),
        ],
      ),
    );
  }

  InkWell newMethod(BuildContext context, DarkModeModel darkModeModel) {
    return InkWell(
      onTap: () => controller.changeDarkMode(darkModeModel.themeMode),
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        title: Text(
          darkModeModel.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: LocalDB.getThemeMode == darkModeModel.themeMode
            ? const Icon(Icons.check, size: 28, color: Colors.green)
            : const SizedBox(),
      ),
    );
  }
}
