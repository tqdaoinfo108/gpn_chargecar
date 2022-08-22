import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
        padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
        child: Row(
          children: [
            const SizedBox(width: Space.large),
            const CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://vtv1.mediacdn.vn/thumb_w/650/2022/3/4/avatar-jake-neytiri-pandora-ocean-1646372078251163431014-crop-16463720830272075805905.jpg'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: Space.large),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trần Quốc Đạo",
                    style: theme.textTheme.bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "qdao.cntt@gmail.com",
                    style: theme.textTheme.bodyText2,
                  ),
                ],
              ),
            )
          ],
        ),
            ),
            Container(
        color: Colors.grey.withOpacity(.2),
        height: Space.small,
        margin: const EdgeInsets.symmetric(
            vertical: Paddings.kDialogContentPadding),
            ),
            Padding(
        padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
        child: Text("ACCOUNT SETTINGS",
            style: theme.textTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.bold)),
            ),
            itemSetting("Verify account", "Not Verified",icon: Icon(Icons.warning, color: Colors.red,)),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("Infomation account", "quocdaopy97"),
            Container(
        color: Colors.grey.withOpacity(.2),
        height: Space.small,
        margin: const EdgeInsets.symmetric(
            vertical: Paddings.kDialogContentPadding),
            ),
            Padding(
        padding: const EdgeInsets.symmetric(horizontal: Paddings.normal),
        child: Text("SETTINGS",
            style: theme.textTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.bold)),
            ),
            itemSetting("Dark mode", "Light"),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("Language", "English"),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("Version", "beta 1.0.0"),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("About", "GPN-Avanced"),
            Divider(thickness: 1, color: Colors.grey.withOpacity(.2)),
            itemSetting("Contact me", "(+84) 257 999 999"),
          ]),
      ),
    );
  }
}

ListTile itemSetting(String title, String value, {Icon? icon}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(
        horizontal: Paddings.kDialogContentPadding, vertical: 0),
    title: Text(title),
    subtitle: Text(value),
    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    trailing: IconButton(
      icon: icon ?? const RotatedBox(
          quarterTurns: 90, child: Icon(Icons.arrow_back_ios_outlined)),
      onPressed: () {},
    ),
  );
}
