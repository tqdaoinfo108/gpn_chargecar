import 'package:charge_car/services/model/booking_detail.dart';
import 'package:charge_car/services/model/notification.dart';
import 'package:charge_car/services/model/parking.dart';
import 'package:charge_car/services/model/response_base.dart';
import 'package:charge_car/services/model/user.dart';

class HomeModel {
  UserModel? userModel;
  List<ParkingModel>? listParking;
  ResponseBase<List<NotificationModel>>? listNotification;
  ResponseBase<List<BookingDetail>>? listBookingDetail;

  HomeModel(
      {this.userModel,
      this.listParking,
      this.listNotification,
      this.listBookingDetail});
}
