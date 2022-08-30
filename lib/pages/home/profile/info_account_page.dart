import 'package:charge_car/third_library/scaffold_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../constants/dimens.dart';
import '../../../services/model/user.dart';
import '../../../services/servces.dart';
import '../../../third_library/button_default.dart';
import '../../../third_library/custom_text_form_field.dart';
import '../../../utils/get_storage.dart';

class InfoAccountPage extends StatefulWidget {
  const InfoAccountPage({Key? key}) : super(key: key);

  @override
  State<InfoAccountPage> createState() => _InfoAccountPageState();
}

class _InfoAccountPageState extends State<InfoAccountPage> {
  String fullName = "";
  String email = "";
  String phone = "";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> infoAccountKey = GlobalKey<FormState>();
  UserModel userData = UserModel();

  Future<bool?> getProfile() async {
    EasyLoading.show();
    try {
      var response = await HttpClientLocal().getProfile(LocalDB.getUserID);
      userData = UserModel.getUserResponse(response.data).data!;
      fullNameController.text = userData.fullName ?? "";
      phoneController.text = userData.phone ?? "";
      setState(() {});
      return true;
    } catch (e) {
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Widget _buildRegisterForm(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Form(
      key: infoAccountKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Paddings.normal),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Paddings.minimum),
              ),
              padding: const EdgeInsets.only(
                  left: Paddings.normal, top: Paddings.normal),
              child: CustomTextFormField(
                initialValue: userData.email,
                enabled: false,
                textInputType: TextInputType.none,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "email".tr,
                titleStyle: theme.textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                hasTitleIcon: true,
                titleIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.email_outlined,
                      color: Theme.of(context).primaryColor, size: 16),
                ),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none)),
                hintTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).dividerColor, fontSize: 14),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "email".tr,
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return 'dont_blank'.tr;
                  }

                  if (s.length < 6) {
                    return "more_than_6".tr;
                  }

                  if (!s.isEmail) {
                    return "email_invalid".tr;
                  }
                },
              ),
            ),
            const SizedBox(height: Space.medium),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: CustomTextFormField(
                controller: fullNameController,
                initialValue: userData.fullName ?? "",
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "full_name".tr,
                titleStyle: theme.textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                hasTitleIcon: true,
                titleIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.password_outlined,
                      color: Theme.of(context).primaryColor, size: 16),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
                obscured: false,
                hintTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).dividerColor, fontSize: 14),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "full_name".tr,
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return 'dont_blank'.tr;
                  }

                  if (s.length < 6) {
                    return "more_than_6".tr;
                  }
                },
                onChanged: (s) {
                  fullName = s;
                },
              ),
            ),
            const SizedBox(height: Space.medium),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.only(left: 12, top: 12),
              child: CustomTextFormField(
                controller: phoneController,
                initialValue: userData.phone ?? "",
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "phone".tr,
                titleStyle: theme.textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                hasTitleIcon: true,
                titleIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.phone,
                      color: Theme.of(context).primaryColor, size: 16),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
                obscured: false,
                hintTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).dividerColor, fontSize: 14),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "phone".tr,
              ),
            ),
            const SizedBox(height: Space.superLarge),
            SizedBox(
              width: widthOfScreen * 0.6,
              child: DefaultButton(
                  text: 'Save'.tr,
                  textColor: Colors.white,
                  backgroundColor: theme.primaryColor,
                  press: () async {
                    if (infoAccountKey.currentState!.validate()) {}
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault('info_account'.tr, _buildRegisterForm(context));
  }
}
