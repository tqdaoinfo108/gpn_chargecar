import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/third_library/button_default.dart';
import 'package:charge_car/third_library/scaffold_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../third_library/custom_text_form_field.dart';
import 'sign_in_controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    final signInFormKey = GlobalKey<FormState>();
    final signUpFormKey = GlobalKey<FormState>();

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
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "Email",
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
                hintText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field don't blank";
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
                title: "Password",
                titleStyle: theme.textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                hasTitleIcon: true,
                titleIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.email_outlined,
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
                hintText: "Password",
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return "Field don't blank";
                  }

                  if (s.length < 6) {
                    return "length < 6";
                  }
                },
                onChanged: (s) {
                  controller.signInPassword.value = s;
                },
              ),
            ),
            const SizedBox(height: Space.superLarge),
            SizedBox(
              width: widthOfScreen * 0.6,
              child: DefaultButton(
                  text: 'Login',
                  textColor: Colors.white,
                  backgroundColor: theme.primaryColor,
                  press: () async {
                    if (signInFormKey.currentState!.validate()) {
                      var result = await controller.signIn();
                      if(result){
                        Get.offAllNamed("/splash");
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
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "Email",
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
                hintText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field don't blank";
                  }

                  if (!value.isEmail) {
                    return "Email don't incorect";
                  }
                  return "";
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
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "Password",
                titleStyle: theme.textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                hasTitleIcon: true,
                titleIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.email_outlined,
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
                hintText: "Password",
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return "Field don't blank";
                  }

                  if (s.length < 6) {
                    return "length < 6";
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
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "Confirm password",
                titleStyle: theme.textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14),
                hasTitleIcon: true,
                titleIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.email_outlined,
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
                hintText: "Password",
                validator: (s) {
                  if (s == null || s.isEmpty) {
                    return "Field don't blank";
                  }

                  if (s.length < 6) {
                    return "length < 6";
                  }
                },
                onChanged: (s) {
                  controller.signUpPasswordConfirm.value = s;
                },
              ),
            ),
            const SizedBox(height: Space.superLarge),
            Container(
              width: widthOfScreen * 0.6,
              child: DefaultButton(
                  text: 'Register',
                  textColor: Colors.white,
                  backgroundColor: theme.primaryColor,
                  press: () {
                    if (signInFormKey.currentState!.validate()) {}
                  }),
            ),
          ],
        ),
      );
    }

    Widget _buildTabView(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TabBarView(
              children: [
                Form(key: signInFormKey, child: buildLoginForm()),
                Form(key: signUpFormKey, child: _buildRegisterForm(context)),
              ],
            ),
          )
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
                          MediaQuery.of(context).size.width * .42,
                          heightOfScreen / 2.6,
                          0.0),
                      child: Text(
                        "ChargeCar v1.0.0",
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
                      labelStyle: theme.textTheme.subtitle1!
                          .copyWith(color: Theme.of(context).dividerColor),
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).dividerColor,
                      tabs: [
                        Tab(text: "Sign In"),
                        Tab(text: "Register"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (heightOfScreen * 0.05),
                  ),
                  SizedBox(
                    height: 400,
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
