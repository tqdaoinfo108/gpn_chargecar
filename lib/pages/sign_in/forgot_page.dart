// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../constants/dimens.dart';
import '../../services/servces.dart';
import '../../third_library/bottom_sheet_default.dart';
import '../../third_library/button_default.dart';
import '../../third_library/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String emailValue = "";
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BottomSheetDefault(
      title: "reset_password".tr,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Paddings.minimum),
              ),
              padding: const EdgeInsets.only(
                  left: Paddings.normal, top: Paddings.normal),
              child: CustomTextFormField(
                controller: emailController,
                textInputType: TextInputType.text,
                textFormFieldMargin: const EdgeInsets.only(
                    left: Paddings.normal + Paddings.minimum),
                hasTitle: true,
                title: "email".tr,
                titleStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
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

                  if (!emailValue.isEmail) {
                    return "Email don't incorect";
                  }
                },
                onChanged: (s) {
                  emailValue = s;
                },
              ),
            ),
            const SizedBox(height: Space.superLarge),
            SizedBox(
              width: Get.width * 0.6,
              child: DefaultButton(
                  text: "reset_password".tr,
                  textColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  press: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        EasyLoading.show();
                        await HttpClientLocal()
                            .postForgotPassword(emailController.text);
                        EasyLoading.showError('success'.tr);
                        Get.back();
                      } catch (e) {
                        EasyLoading.showError('fail_again'.tr);
                        return false;
                      } finally {
                        EasyLoading.dismiss();
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
