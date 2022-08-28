import 'package:charge_car/services/model/user.dart';
import 'package:charge_car/utils/get_storage.dart';
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

  Future<bool> signIn() async {
    EasyLoading.show();
    var response = await HttpClientLocal()
        .postLogin(signInEmail.value, signInPassword.value);
    var userModel = UserModel.getUserResponse(response.data);
    if (userModel.message ==null ) {
      LocalDB.setUserID = userModel.data?.userID ?? 0;
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Login success");
      return true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(userModel.message ?? "");
      return false;
    }
  }
}