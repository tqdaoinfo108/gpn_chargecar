import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/home/home_controller.dart';
import 'package:charge_car/pages/home/profile/language_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/get_storage.dart';
import 'dark_mode_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(this.controller, {Key? key}) : super(key: key);
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: Paddings.kDialogContentPadding),
          GestureDetector(
            onTap: (() =>
                LocalDB.getUserID == 0 ? Get.toNamed("/login") : null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 32.0,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: Space.large),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocalDB.getUserID != 0
                            ? controller.homeData.value.userModel?.fullName ??
                                ""
                            : "Đăng nhập/ Đăng ký",
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        LocalDB.getUserID != 0
                            ? controller.homeData.value.userModel?.email ?? ""
                            : "",
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(.2),
            height: Space.small,
            margin: const EdgeInsets.symmetric(
                vertical: Paddings.kDialogContentPadding),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalDB.getUserID == 0
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Paddings.normal),
                              child: Text('account'.tr,
                                  style: theme.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            itemSetting('verify_account'.tr,
                                value: (controller.homeData.value.userModel!
                                                .confirmEmail ??
                                            0) ==
                                        1
                                    ? "verified".tr
                                    : "not_verified".tr,
                                icon: (controller.homeData.value.userModel!
                                                .confirmEmail ??
                                            0) ==
                                        1
                                    ? Icon(Icons.check,
                                        color: theme.primaryColor)
                                    : const Icon(Icons.warning,
                                        color: Colors.red)),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Colors.grey.withOpacity(.2)),
                            itemSetting("info_account".tr,
                                value: controller
                                    .homeData.value.userModel?.fullName,
                                onPressed: () => Get.toNamed("/info_account")),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Colors.grey.withOpacity(.2)),
                            itemSetting("delete_account".tr),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Colors.grey.withOpacity(.2)),
                            itemSetting("sign_out".tr, onPressed: () {
                              LocalDB.setUserID = 0;
                              Get.offAllNamed("/splash");
                            }),
                            Container(
                              color: Colors.grey.withOpacity(.2),
                              height: Space.small,
                              margin: const EdgeInsets.only(
                                  bottom: Paddings.normal),
                            ),
                          ],
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Paddings.normal),
                    child: Text("settings".tr,
                        style: theme.textTheme.titleSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  itemSetting("dark_mode".tr,
                      value: controller.listDarkMode
                          .firstWhere(
                              (element) => element.code == LocalDB.getThemeMode)
                          .title, onPressed: () {
                    Get.bottomSheet(const DarkModePage());
                  }),
                  Divider(
                      thickness: 1,
                      height: 1,
                      color: Colors.grey.withOpacity(.2)),
                  itemSetting("language".tr,
                      value: controller.lstLanguage
                          .firstWhere((element) =>
                              element.locale == Locale(LocalDB.getLanguagCode))
                          .title,
                      onPressed: () => Get.bottomSheet(const LanguagePage())),
                  // Divider(
                  //     thickness: 1,
                  //     height: 1,
                  //     color: Colors.grey.withOpacity(.2)),
                  // itemSetting("About", value: "GPN-Avanced"),
                  Divider(
                      thickness: 1,
                      height: 1,
                      color: Colors.grey.withOpacity(.2)),
                  itemSetting("version".tr,
                      value: "beta 1.0.0",
                      onPressed: () => EasyLoading.showToast(
                          toastPosition: EasyLoadingToastPosition.top,
                          "${'app_version'.tr} 1.0.0")),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

GestureDetector itemSetting(String title,
    {String? value, Icon? icon, Function? onPressed}) {
  return GestureDetector(
    onTap: () => {if (onPressed != null) onPressed.call()},
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Paddings.kDialogContentPadding,
          vertical: Paddings.minimum),
      title: Text(title),
      subtitle: value == null ? null : Text(value),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      trailing: icon ??
          const RotatedBox(
            quarterTurns: 90,
            child: Icon(Icons.arrow_back_ios_outlined),
          ),
    ),
  );
}
