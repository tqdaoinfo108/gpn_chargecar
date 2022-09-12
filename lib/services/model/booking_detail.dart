import 'package:charge_car/utils/get_storage.dart';

import 'response_base.dart';

class BookingDetail {
  int? bookId;
  String? code;
  int? dateBook;
  int? dateStart;
  int? dateEnd;
  double? powerConsumption;
  double? unitPrice;
  double? amount;
  int? userId;
  int? statusBooking;
  String? timeZoneName;
  String? desriptionBooking;
  int? createdDate;
  int? updatedDate;
  String? userCreated;
  String? userUpdated;
  int? parkingId;
  String? codeParking;
  String? nameParking;
  String? addressParking;
  String? phoneParking;
  int? statusParking;
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

  BookingDetail(
      {this.bookId,
      code,
      dateBook,
      dateStart,
      dateEnd,
      powerConsumption,
      unitPrice,
      amount,
      userId,
      statusBooking,
      timeZoneName,
      desriptionBooking,
      createdDate,
      updatedDate,
      userCreated,
      userUpdated,
      parkingId,
      codeParking,
      nameParking,
      addressParking1,
      addressParking2,
      addressParking3,
      addressParking4,
      addressParking5,
      phoneParking,
      statusParking,
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
      statusCPowerSocket});

  BookingDetail.fromJson(Map<String, dynamic> json) {
    this.bookId = json["BookID"];
    this.code = json["Code"];
    this.dateBook = json["DateBook"];
    this.dateStart = json["DateStart"];
    this.dateEnd = json["DateEnd"];
    this.powerConsumption = json["PowerConsumption"];
    this.unitPrice = json["UnitPrice"];
    this.amount = json["Amount"];
    this.userId = json["UserID"];
    this.statusBooking = json["StatusBooking"];
    this.timeZoneName = json["TimeZoneName"];
    this.desriptionBooking = json["DesriptionBooking"];
    this.createdDate = json["CreatedDate"];
    this.updatedDate = json["UpdatedDate"];
    this.userCreated = json["UserCreated"];
    this.userUpdated = json["UserUpdated"];
    this.parkingId = json["ParkingID"];
    this.codeParking = json["CodeParking"];
    this.nameParking = json["NameParking"];
    this.addressParking = json["AddressParking"];
    this.phoneParking = json["PhoneParking"];
    this.statusParking = json["StatusParking"];
    this.areaId = json["AreaID"];
    this.areaIdMqtt = json["AreaID_MQTT"];
    this.nameArea = json["NameArea"];
    this.statusArea = json["StatusArea"];
    this.charingPostId = json["CharingPostID"];
    this.charingPostIdMqtt = json["CharingPostID_MQTT"];
    this.chargingPostName = json["ChargingPostName"];
    this.statusChargingPost = json["StatusChargingPost"];
    this.powerSocketId = json["PowerSocketID"];
    this.powerSocketIdMqtt = json["PowerSocketID_MQTT"];
    this.powerSocketName = json["PowerSocketName"];
    this.statusCPowerSocket = json["StatusCPowerSocket"];
    this.timeStopCharging = json["TimeStopCharging"];
  }

  static ResponseBase<List<BookingDetail>> getListBookingDetailResponse(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <BookingDetail>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(BookingDetail.fromJson(v));
        });
      }
      return ResponseBase<List<BookingDetail>>(
        totals: json['totals'],
        data: list,
      );
    } else {
      return ResponseBase(message: json["message"]);
    }
  }

  static ResponseBase<BookingDetail> getBookingDetailResponse(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<BookingDetail>(
          data: BookingDetail.fromJson(json["data"]));
    } else {
      return ResponseBase(message: json["message"]);
    }
  }

  Map<String, dynamic> toInsertBookingJson(String qrCode, int parkingID2, int timeStopCharging) {
    final Map<String, dynamic> auth = <String, dynamic>{};
    auth["UserID"] = LocalDB.getUserID;
    auth["UUSerID"] = "";

    final Map<String, dynamic> data = <String, dynamic>{};
    data["ParkingID"] = parkingID2;
    data["QRCode"] = qrCode;
    data["TimeZoneName"] = LocalDB.getLanguagCode;
    data["TimeStopCharging"] = timeStopCharging;

    final Map<String, dynamic> result = <String, dynamic>{};
    result["auth"] = auth;
    result["data"] = data;

    return result;
  }
}
