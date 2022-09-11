import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:charge_car/services/model/home.dart';
import 'package:charge_car/services/model/notification.dart';
import 'package:charge_car/services/model/response_base.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../services/model/booking_detail.dart';
import '../../services/model/parking.dart';
import '../../services/model/user.dart';
import '../../services/servces.dart';
import '../../utils/get_storage.dart';
import '../../services/model/home.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
  }
}

class SplashScreenController extends GetxController {
  HomeModel homeModel = HomeModel();
  LatLng latlng = LatLng(0, 0);
  var isPermission = true.obs;
  var isRetry = false.obs;

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
    onInitCheckAll();
  }

  Future<void> onInitCheckAll() async {
    if (!await checkPermission()) {
      isPermission.value = false;
      return;
    }

    // login
    if (LocalDB.getUserID == 0) {
      Get.offAllNamed("/login");
      return;
    }
    loadingIntoHome();
  }

  Future<bool> checkPermission() async {
    try {
      await [
        Permission.location,
        Permission.camera,
      ].request();

      var isLocation = await Permission.location.request().isGranted;
      var isCamera = await Permission.camera.request().isGranted;
      isPermission.value = isLocation && isCamera;
      return isLocation && isCamera;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loadingIntoHome({bool isSkip = false}) async {
    isRetry.value = false;
    if (isSkip) {
      isPermission.value = true;
    }

    if (LocalDB.getUserID == 0) {
      Get.offAllNamed("/login");
      return true;
    }

    var response = await Future.wait([
      getProfile(),
      getListParking(),
      getNotification(1),
      getListBookingDetail()
    ]);

    if (!response.contains(null)) {
      Get.offAllNamed(LocalDB.getUserID == 0 ? "/login" : "/",
          arguments: homeModel);
      return true;
    }

    isRetry.value = true;
    EasyLoading.showToast('server_busy'.tr);
    return false;
  }

  Future<bool?> getProfile() async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getProfile(LocalDB.getUserID);
      homeModel.userModel = UserModel.getUserResponse(response.data).data;
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> getNotification(int page) async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getListNotification(page);
      var raw = NotificationModel.getListNotificationResponse(response.data);

      homeModel.listNotification =
          ResponseBase(data: RxList(raw.data!), totals: raw.totals, page: 2);
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> getListParking() async {
    try {
      var response = await HttpClientLocal().getListChargeCarLocaltion(
          "", 1, 1000,
          lat: latlng.latitude, lng: latlng.longitude);
      homeModel.listParking =
          ParkingModel.getListParkingResponse(response.data).data;
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> getListBookingDetail() async {
    if (LocalDB.getUserID == 0) return true;

    try {
      var response = await HttpClientLocal().getListBookingDetail(-100, 1);
      var raw = BookingDetail.getListBookingDetailResponse(response.data);

      homeModel.listBookingDetail =
          ResponseBase(data: RxList(raw.data!), totals: raw.totals, page: 2);

      return true;
    } catch (e) {
      return null;
    }
  }

  Future<BookingDetail?> checkBookingExist() async {
    if (LocalDB.getUserID == 0) return null;

    try {
      var response =
          await HttpClientLocal().getBookingExist(LocalDB.getUserID, 0);
      var booking = BookingDetail.getBookingDetailResponse(response.data);
      if (booking.message == null) {
        return booking.data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
