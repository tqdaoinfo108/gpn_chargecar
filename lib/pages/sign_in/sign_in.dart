import 'package:charge_car/constants/dimens.dart';
import 'package:charge_car/constants/index.dart';
import 'package:charge_car/third_library/button_default.dart';
import 'package:charge_car/third_library/scaffold_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../third_library/custom_text_form_field.dart';
import '../home/home_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    // backgroundColor: Theme.of(context).scaffoldBackgroundColor
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
              Transform(
                  transform: Matrix4.translationValues(
                      MediaQuery.of(context).size.width * .4, 40.0, 0.0),
                  child: SvgPicture.asset('assets/svg/svg_splashscreen.svg',
                      width: 300)),
              ListView(
                children: <Widget>[
                  SizedBox(
                    height: (heightOfScreen * 0.05) + (widthOfScreen * 0.5),
                  ),
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
                        Tab(text: "SignIn"),
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

  Widget _buildTabView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TabBarView(
            children: [
              _buildLoginForm(context),
              _buildRegisterForm(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
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
            ),
          ),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: CustomTextFormField(
              textInputType: TextInputType.text,
              textFormFieldMargin: EdgeInsets.only(left: 26),
              hasTitle: true,
              title: "Password",
              titleStyle: theme.textTheme.subtitle1!.copyWith(
                color: Colors.red,
                fontSize: 14,
              ),
              hasTitleIcon: true,
              titleIcon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.lock,
                  color: Colors.red,
                  size: 16,
                ),
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
              hintTextStyle: Theme.of(context).textTheme.subtitle1,
              textStyle: Theme.of(context).textTheme.bodyMedium,
              hintText: "Password",
            ),
          ),
          const SizedBox(height: Space.medium),
          Container(
            width: widthOfScreen * 0.6,
            child: DefaultButton(
                text: 'Get start',
                textColor: theme.colorScheme.primary,
                backgroundColor: theme.primaryColor,
                press: () => Get.to(HomePage())),
          )
        ],
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.only(left: 12, top: 12),
            child: CustomTextFormField(
              textInputType: TextInputType.text,
              textFormFieldMargin: EdgeInsets.only(left: 26),
              hasTitle: true,
              title: "StringConst.USER_NAME",
              titleStyle: theme.textTheme.subtitle1!.copyWith(
                color: Colors.red,
                fontSize: 14,
              ),
              hasTitleIcon: true,
              titleIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.percent,
                  color: Colors.red,
                  size: 16,
                ),
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
              // hintTextStyle: Styles.customTextStyle(color: Colors.redShade1),
              // textStyle: Styles.customTextStyle(color: Colors.redShade1),
              hintText: "StringConst.USERNAME_HINT_TEXT",
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: widthOfScreen * 0.6,
            child: DefaultButton(
                text: 'Get start',
                textColor: theme.colorScheme.primary,
                backgroundColor: theme.primaryColor,
                press: () => Get.to(HomePage())),
          ),
        ],
      ),
    );
  }
}
