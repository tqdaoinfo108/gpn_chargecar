import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/pages/home/home_controller.dart';
import 'package:charge_car/pages/profile/dark_mode_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
              child: Row(
                children: [
                  const SizedBox(width: Space.large),
                  const CircleAvatar(
                    radius: 32.0,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: Space.large),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đăng nhập/ Đăng ký",
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "",
                          style: theme.textTheme.bodyText2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Storage.getUserID == 0
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(.2),
                        height: Space.small,
                        margin: const EdgeInsets.symmetric(
                            vertical: Paddings.kDialogContentPadding),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Paddings.normal),
                        child: Text("ACCOUNT SETTINGS",
                            style: theme.textTheme.titleSmall!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      itemSetting("Verify account", "Not Verified",
                          icon: const Icon(Icons.warning, color: Colors.red)),
                      Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
                      itemSetting("Infomation account", "quocdaopy97"),
                    ],
                  ),
            Container(
              color: Colors.grey.withOpacity(.2),
              height: Space.small,
              margin: const EdgeInsets.symmetric(
                  vertical: Paddings.kDialogContentPadding),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
              child: Text("SETTINGS",
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            itemSetting("Dark mode", "Light", onPressed: () {
              Get.bottomSheet(DarkModePage());
            }),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("Language", "English"),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("About", "GPN-Avanced"),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("Contact me", "(+84) 257 999 999"),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("Version", "beta 1.0.0"),
          ]),
        ),
      );
    });
  }
}

InkWell itemSetting(String title, String value,
    {Icon? icon, Function? onPressed}) {
  return InkWell(
    onTap: () => {if (onPressed != null) onPressed.call()},
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Paddings.kDialogContentPadding, vertical: 0),
      title: Text(title),
      subtitle: Text(value),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      trailing: icon ??
          const RotatedBox(
            quarterTurns: 90,
            child: Icon(Icons.arrow_back_ios_outlined),
          ),
    ),
  );
}
