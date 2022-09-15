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
  String? amountString;
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
    bookId = json["BookID"];
    code = json["Code"];
    dateBook = json["DateBook"];
    dateStart = json["DateStart"];
    dateEnd = json["DateEnd"];
    powerConsumption = json["PowerConsumption"];
    unitPrice = json["UnitPrice"];
    amount = json["Amount"];
    userId = json["UserID"];
    statusBooking = json["StatusBooking"];
    timeZoneName = json["TimeZoneName"];
    desriptionBooking = json["DesriptionBooking"];
    createdDate = json["CreatedDate"];
    updatedDate = json["UpdatedDate"];
    userCreated = json["UserCreated"];
    userUpdated = json["UserUpdated"];
    parkingId = json["ParkingID"];
    codeParking = json["CodeParking"];
    nameParking = json["NameParking"];
    addressParking = json["AddressParking"];
    phoneParking = json["PhoneParking"];
    statusParking = json["StatusParking"];
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
    amountString = json["AmountString"];
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

  Map<String, dynamic> toInsertBookingJson(
      String qrCode, int parkingID2, int timeStopCharging) {
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
