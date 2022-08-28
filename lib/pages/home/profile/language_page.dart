import 'package:charge_car/pages/home/home_controller.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../third_library/bottom_sheet_default.dart';

final HomeController controller = Get.put(HomeController());

class LocaleModel {
  String title;
  Locale locale;

  LocaleModel(this.title, this.locale);
}

// ignore: must_be_immutable
class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetDefault(
      title: "Language",
      body: Column(
        children: [
          newMethod(context,controller.lstLanguage[0]),
          Divider(thickness: 0.5, color: Colors.grey.withOpacity(0.1)),
          newMethod(context,controller.lstLanguage[1]),
        ],
      ),
    );
  }

  InkWell newMethod(BuildContext context,LocaleModel localeModel) {
    return InkWell(
      onTap: () => controller.changeLanguage(localeModel.locale),
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        title: Text(
          localeModel.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: LocalDB.getLanguagCode == localeModel.locale.languageCode
            ? const Icon(Icons.check, size: 28, color: Colors.green)
            : const SizedBox(),
      ),
    );
  }
}
