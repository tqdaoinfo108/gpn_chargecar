import 'dart:convert';

import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/home/home_controller.dart';
import 'package:charge_car/pages/home/profile/language_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../utils/const.dart';
import '../../../utils/get_storage.dart';
import 'dark_mode_page.dart';

Widget profilePage(BuildContext context, HomeController controller) {
  var theme = Theme.of(context);

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

  return Obx(
    () => Scaffold(
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
                  controller.homeData.value.userModel!.imagesPaths!
                          .trim()
                          .isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey.shade500,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 32.0,
                            backgroundImage: MemoryImage(base64Decode(controller
                                .homeData.value.userModel!.imagesPaths!)),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey.shade500,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 32.0,
                            backgroundImage:
                                AssetImage("assets/images/profile.png"),
                            backgroundColor: Colors.transparent,
                          ),
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
                                value: controller.homeData.value.userModel
                                    ?.fullName, onPressed: () async {
                              var result = await Get.toNamed("/info_account");
                              if (result != null) {
                                controller.homeData.value.userModel = result;
                                controller.homeData.refresh();
                              }
                            }),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Colors.grey.withOpacity(.2)),
                            itemSetting("delete_account".tr, onPressed: () {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'notification'.tr,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'delete_account_message'.tr,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('no'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('yes'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        onPressed: () {
                                          controller.onLogout();
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                            Divider(
                                thickness: 1,
                                height: 1,
                                color: Colors.grey.withOpacity(.2)),
                            itemSetting("sign_out".tr, onPressed: () {
                              LocalDB.setUserID = 0;
                              Get.delete<HomeController>(force: true);
                              Get.back(result: true);
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
                      value: DarkModePage.getTitle(controller.listDarkMode
                          .firstWhere(
                              (element) => element.code == LocalDB.getThemeMode)
                          .code), onPressed: () {
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
                      value: Constants.APP_VERSION,
                      onPressed: () => EasyLoading.showToast(
                          toastPosition: EasyLoadingToastPosition.top,
                          "${'app_version'.tr} ${Constants.APP_VERSION}")),
                ],
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
