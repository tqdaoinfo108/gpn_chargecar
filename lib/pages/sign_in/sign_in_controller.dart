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

class SignInController extends GetxController with GetTickerProviderStateMixin {
  var signInEmail = "".obs;
  var signInPassword = "".obs;

  var signUpEmail = "".obs;
  var signUpPassword = "".obs;
  var signUpPasswordConfirm = "".obs;

  final signInFormKey = GlobalKey<FormState>().obs;
  final signUpFormKey = GlobalKey<FormState>().obs;

  final Rx<TextEditingController> signInEmailController =
      Rx<TextEditingController>(TextEditingController());

  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  late Rx<TabController?> tabController = Rx(null);

  @override
  void onInit() {
    super.onInit();
    tabController.value = TabController(vsync: this, length: 2);
  }

  Future<bool> signIn() async {
    EasyLoading.show();
    try {
      var response = await HttpClientLocal()
          .postLogin(signInEmail.value, signInPassword.value);
      var userModel = UserModel.getUserResponse(response.data);
      if (userModel.message == null) {
        if (userModel.data!.confirmEmail == 0) {
          EasyLoading.showError("account_nonactive".tr);
          return false;
        }
        LocalDB.setUserID = userModel.data?.userID ?? 0;
        EasyLoading.showSuccess("login_success");
        return true;
      } else {
        EasyLoading.showError('user_pass_invalid'.tr);
        return false;
      }
    } catch (e) {
      EasyLoading.showError("fail_again".tr);
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
        EasyLoading.showSuccess("register_success_message".tr);
        tabController.value!.animateTo(0);
        signInEmailController.value.text = signUpEmail.value;
        signInEmailController.refresh();
        signUpPasswordController.text = "";
        signUpConfirmPasswordController.text = "";
        return true;
      } else {
        EasyLoading.showError(userModel.message ?? "");
        return false;
      }
    } catch (e) {
      EasyLoading.showError("fail_again".tr);
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
