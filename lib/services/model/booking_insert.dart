import 'package:charge_car/services/model/response_base.dart';
import 'package:charge_car/services/model/user.dart';

class BookingInsertModel {
  int? parkingId;
  String? codeParking;
  String? nameParking;
  String? addressParking1;
  String? addressParking2;
  String? addressParking3;
  String? addressParking4;
  String? addressParking5;
  String? phoneParking;
  int? status;
  int? areaId;
  String? areaIdMqtt;
  String? nameArea;
  int? statusArea;
  int? charingPostId;
  String? charingPostIdMqtt;
  String? chargingPostName;
  int? statusChargingPost;
  int? powerSocketId;
  String? powerSocketIdMqtt;
  String? powerSocketName;
  int? statusCPowerSocket;
  int? timeStopCharging;
  String? qrCode;
  int? bookingStart;
  int? bookingID;
  int? duration;
  BookingInsertModel(
      {this.parkingId,
      codeParking,
      nameParking,
      addressParking1,
      addressParking2,
      addressParking3,
      addressParking4,
      addressParking5,
      phoneParking,
      status,
      areaId,
      areaIdMqtt,
      nameArea,
      statusArea,
      charingPostId,
      charingPostIdMqtt,
      chargingPostName,
      statusChargingPost,
      powerSocketId,
      powerSocketIdMqtt,
      powerSocketName,
      statusCPowerSocket,
      qrCode,
      this.bookingID,
      this.bookingStart,
      this.duration});

  BookingInsertModel.fromJson(Map<String, dynamic> json) {
    parkingId = json["ParkingID"];
    codeParking = json["CodeParking"];
    nameParking = json["NameParking"];
    addressParking1 = json["AddressParking1"];
    addressParking2 = json["AddressParking2"];
    addressParking3 = json["AddressParking3"];
    addressParking4 = json["AddressParking4"];
    addressParking5 = json["AddressParking5"];
    phoneParking = json["PhoneParking"];
    status = json["Status"];
    areaId = json["AreaID"];
    areaIdMqtt = json["AreaID_MQTT"];
    nameArea = json["NameArea"];
    statusArea = json["StatusArea"];
    charingPostId = json["CharingPostID"];
    charingPostIdMqtt = json["CharingPostID_MQTT"];
    chargingPostName = json["ChargingPostName"];
    statusChargingPost = json["StatusChargingPost"];
    powerSocketId = json["PowerSocketID"];
    powerSocketIdMqtt = json["PowerSocketID_MQTT"];
    powerSocketName = json["PowerSocketName"];
    statusCPowerSocket = json["StatusCPowerSocket"];
    timeStopCharging = json["TimeStopCharging"];
  }

  static ResponseBase<BookingInsertModel> getBookingInsertResponse(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<BookingInsertModel>(
          data: BookingInsertModel.fromJson(json["data"]));
    } else {
      return ResponseBase(message: json["message"]);
    }
  }
}
