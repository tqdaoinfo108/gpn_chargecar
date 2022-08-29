import 'package:charge_car/services/model/user.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../services/servces.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}

class SignInController extends GetxController {
  var signInEmail = "".obs;
  var signInPassword = "".obs;

  var signUpEmail = "".obs;
  var signUpPassword = "".obs;
  var signUpPasswordConfirm = "".obs;

  final signInFormKey = GlobalKey<FormState>().obs;
  final signUpFormKey = GlobalKey<FormState>().obs;

  Future<bool> signIn() async {
    EasyLoading.show();
    try {
      var response = await HttpClientLocal()
          .postLogin(signInEmail.value, signInPassword.value);
      var userModel = UserModel.getUserResponse(response.data);
      if (userModel.message == null) {
        LocalDB.setUserID = userModel.data?.userID ?? 0;
        EasyLoading.showSuccess("Login success");
        return true;
      } else {
        EasyLoading.showError(userModel.message ?? "");
        return false;
      }
    } catch (e) {
      EasyLoading.showError("Operation failed, please try again later.");
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<bool> register() async {
    EasyLoading.show();
    try {
      var response = await HttpClientLocal()
          .postRegister(signUpEmail.value, signUpPassword.value);
      var userModel = UserModel.getUserResponse(response.data);
      if (userModel.message == null) {
        LocalDB.setUserID = userModel.data?.userID ?? 0;
        EasyLoading.showSuccess("Register success");
        return true;
      } else {
        EasyLoading.showError(userModel.message ?? "");
        return false;
      }
    } catch (e) {
      EasyLoading.showError("Operation failed, please try again later.");
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
