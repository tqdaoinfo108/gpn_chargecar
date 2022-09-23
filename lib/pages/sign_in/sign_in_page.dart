import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/third_library/button_default.dart';
import 'package:charge_car/third_library/scaffold_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../third_library/custom_text_form_field.dart';
import '../../utils/const.dart';
import 'forgot_page.dart';
import 'sign_in_controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    Widget buildLoginForm() {
      var widthOfScreen = MediaQuery.of(context).size.width;
      ThemeData theme = Theme.of(context);
      return Container(
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
                controller: controller.signInEmailController.value,
                textInputType: TextInputType.text,
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

                  // if (!value.isEmail) {
                  //   return "Email don't incorect";
                  // }
                },
                onChanged: (s) {
                  controller.signInEmail.value = s;
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
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "password".tr,
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
                obscured: true,
                hintTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).dividerColor, fontSize: 14),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "password".tr,
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return 'dont_blank'.tr;
                  }

                  if (s.length < 6) {
                    return "more_than_6".tr;
                  }

                  if (s.length > 32) {
                    return "more_than_6".tr;
                  }
                },
                onChanged: (s) {
                  controller.signInPassword.value = s;
                },
              ),
            ),
            const SizedBox(height: Space.large),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(const RegisterPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "reset_password".tr,
                    style: theme.textTheme.bodyText1!.copyWith(
                        color: theme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Space.large),
            SizedBox(
              width: widthOfScreen * 0.6,
              child: DefaultButton(
                  text: 'login'.tr,
                  textColor: Colors.white,
                  backgroundColor: theme.primaryColor,
                  press: () async {
                    if (controller.signInFormKey.value.currentState!
                        .validate()) {
                      var result = await controller.signIn();
                      if (result) {
                        Get.back(result: true);
                      }
                    }
                  }),
            )
          ],
        ),
      );
    }

    Widget _buildRegisterForm(BuildContext context) {
      var widthOfScreen = MediaQuery.of(context).size.width;
      ThemeData theme = Theme.of(context);
      return Container(
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
                controller: controller.signUpEmailController,
                textInputType: TextInputType.text,
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
                onChanged: (s) {
                  controller.signUpEmail.value = s;
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
                controller: controller.signUpPasswordController,
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "password".tr,
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
                obscured: true,
                hintTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).dividerColor, fontSize: 14),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "password".tr,
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return 'dont_blank'.tr;
                  }

                  if (s.length > 32) {
                    return "more_than_6".tr;
                  }

                  if (s.length < 6) {
                    return "more_than_6".tr;
                  }
                },
                onChanged: (s) {
                  controller.signUpPassword.value = s;
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
                controller: controller.signUpConfirmPasswordController,
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "confirm_password".tr,
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
                obscured: true,
                hintTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).dividerColor, fontSize: 14),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                hintText: "confirm_password".tr,
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return 'dont_blank'.tr;
                  }

                  if (s.length < 6) {
                    return "more_than_6".tr;
                  }
                  if (s.length > 32) {
                    return "more_than_6".tr;
                  }
                  if (controller.signUpPassword.value !=
                      controller.signUpPasswordConfirm.value) {
                    return "password_incorrect".tr;
                  }
                },
                onChanged: (s) {
                  controller.signUpPasswordConfirm.value = s;
                },
              ),
            ),
            const SizedBox(height: Space.superLarge),
            SizedBox(
              width: widthOfScreen * 0.6,
              child: DefaultButton(
                  text: 'register'.tr,
                  textColor: Colors.white,
                  backgroundColor: theme.primaryColor,
                  press: () async {
                    if (controller.signUpFormKey.value.currentState!
                        .validate()) {
                      await controller.register();
                    }
                  }),
            ),
          ],
        ),
      );
    }

    Widget _buildTabView(BuildContext context) {
      return TabBarView(
        controller: controller.tabController.value,
        children: [
          Form(key: controller.signInFormKey.value, child: buildLoginForm()),
          Form(
              key: controller.signUpFormKey.value,
              child: _buildRegisterForm(context)),
        ],
      );
    }

    return ScaffoldDefault(
      "",
      DefaultTabController(
        length: 2,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Transform(
                      transform: Matrix4.translationValues(
                          MediaQuery.of(context).size.width * .4,
                          heightOfScreen / 2.5,
                          0.0),
                      child: Image.asset('assets/images/svg_splashscreen.png',
                          width: 300)),
                  Transform(
                      transform: Matrix4.translationValues(
                          MediaQuery.of(context).size.width * .35,
                          heightOfScreen / 2.6,
                          0.0),
                      child: Text(
                        "EvStand充電システム v${Constants.APP_VERSION}",
                        style: theme.textTheme.bodyText1!
                            .copyWith(color: theme.dividerColor),
                      )),
                ],
              ),
              ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: widthOfScreen * 0.1,
                      right: widthOfScreen * 0.3,
                    ),
                    child: TabBar(
                      controller: controller.tabController.value,
                      labelStyle: theme.textTheme.subtitle1!
                          .copyWith(color: Theme.of(context).dividerColor),
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).dividerColor,
                      tabs: [
                        Tab(text: "login".tr),
                        Tab(text: "register".tr),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (heightOfScreen * 0.05),
                  ),
                  SizedBox(
                    height: 500,
                    child: _buildTabView(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
