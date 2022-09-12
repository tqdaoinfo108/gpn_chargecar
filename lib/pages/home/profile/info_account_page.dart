import 'dart:convert';

import 'package:charge_car/third_library/scaffold_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> infoAccountKey = GlobalKey<FormState>();
  UserModel userData = UserModel(imagesPaths: "");

  Future<bool?> getProfile() async {
    EasyLoading.show();
    try {
      var response = await HttpClientLocal().getProfile(LocalDB.getUserID);
      userData = UserModel.getUserResponse(response.data).data!;
      fullNameController.text = userData.fullName ?? "";
      phoneController.text = userData.phone ?? "";
      emailController.text = userData.email ?? "";
      setState(() {});
      return true;
    } catch (e) {
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<bool> updateUser() async {
    EasyLoading.show();
    try {
      var response = await HttpClientLocal().postUpdateUser(
          fullNameController.text, emailController.text, phoneController.text);
      userData = UserModel.getUserResponse(response.data).data!;
      if (UserModel.getUserResponse(response.data).message == null) {
        EasyLoading.showSuccess("success".tr);
        Get.back(result: userData);
      } else {
        EasyLoading.showSuccess("fail".tr);
      }
      return true;
    } catch (e) {
      EasyLoading.showSuccess("fail".tr);
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<bool> updateAvatar(String base64Image) async {
    EasyLoading.show();
    try {
      var response = await HttpClientLocal()
          .postUpdateAvatar(fullNameController.text, base64Image);
      var result = UserModel.getUserResponse(response.data);
      if (result.message == null ) {
        userData = result.data!;
        EasyLoading.showSuccess("success".tr);
        Get.back(result: userData);
      } else {
        EasyLoading.showSuccess("fail".tr);
      }
      return true;
    } catch (e) {
      EasyLoading.showSuccess("fail".tr);
      return false;
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
            GestureDetector(
              onTap: () async {
                try {
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 600,
                    maxHeight: 600,
                    imageQuality: 80,
                  );
                  if (pickedFile != null) {
                    await updateAvatar(
                        base64Encode(await pickedFile.readAsBytes()));
                  }
                  // ignore: empty_catches
                } catch (e) {}
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  (userData.imagesPaths?.isNotEmpty ?? false)
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey.shade500,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 48.0,
                            backgroundImage: MemoryImage(
                                base64Decode(userData.imagesPaths!)),
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
                            radius: 48.0,
                            backgroundImage:
                                AssetImage("assets/images/profile.png"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.camera_enhance,
                      color: theme.colorScheme.primary.withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: Space.superLarge),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Paddings.minimum),
              ),
              padding: const EdgeInsets.only(
                  left: Paddings.normal, top: Paddings.normal),
              child: CustomTextFormField(
                controller: emailController,
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
                  child: Icon(Icons.person,
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
                  text: 'save'.tr,
                  textColor: Colors.white,
                  backgroundColor: theme.primaryColor,
                  press: () async {
                    if (infoAccountKey.currentState!.validate()) {
                      updateUser();
                    }
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
