import 'package:charge_car/services/model/booking_detail.dart';
import 'package:charge_car/services/model/user.dart';
import 'package:charge_car/utils/const.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:dio/dio.dart';
import 'http_client.dart';

class RequestBase {}

class HttpClientLocal {
  Future<Response> getProfile(int userID) => HttpClientHelper()
      .getRequest("/api/user/profile", query: {"userID": userID});

  Future<Response> postLogin(String email, String password) =>
      HttpClientHelper().postRequest("/api/user/login",
          body: {"Email": email, "PassWord": password});

  Future<Response> postRegister(String email, String password) =>
      HttpClientHelper().postRequest("/api/user/register",
          body: {"Email": email, "PassWord": password});

  Future<Response> getListChargeCarLocaltion(
          String keySearch, int page, int limit,
          {double? lat, double? lng}) =>
      HttpClientHelper().getRequest("/api/parkinglot/get", query: {
        "keySearch": keySearch,
        "page": page,
        "limit": limit,
        "Latitude": lat ?? 0,
        "Longitude": lng ?? 0
      });

  Future<Response> getListNotification(int page) =>
      HttpClientHelper().getRequest("/api/notification/getlist", query: {
        "userID": LocalDB.getUserID,
        "languageCode": LocalDB.getLanguagCode,
        "page": page,
        "limit": Constants.PAGE_LIMIT
      });

  Future<Response> getListBookingDetail(int status, int page) =>
      HttpClientHelper().getRequest("/api/booking/gethistorybooking", query: {
        "userID": LocalDB.getUserID,
        "status": status,
        "page": page,
        "limit": Constants.PAGE_LIMIT
      });

  Future<Response> postUpdateUser(
          String fullName, String email, String phone) =>
      HttpClientHelper().postRequest("/api/user/update",
          body: UserModel(fullName: fullName, email: email, phone: phone)
              .toUpdateUserJson(fullName, email, phone));

  Future<Response> postInsertBooking(String qrCode, int parkingID, int time) =>
      HttpClientHelper().postRequest("/api/booking/insert",
          body: BookingDetail().toInsertBookingJson(qrCode, parkingID, time));

  Future<Response> postBookingUpdate(int bookingID) => HttpClientHelper()
      .postRequest("/api/booking/updatestatus", query: {"bookID": bookingID});

  Future<Response> postCheckQRCode(String qrCode, int parkingID) =>
      HttpClientHelper().postRequest("/api/booking/checkqrcode",
          body: BookingDetail().toInsertBookingJson(qrCode, parkingID, 0));

  Future<Response> getBookingExist(int userID, int status) =>
      HttpClientHelper().getRequest("/api/booking/gebookingbyuseridandstatus",
          query: {"UserID": LocalDB.getUserID, "status": status});

  Future<Response> postDeleteAccount(int userID) => HttpClientHelper()
      .postRequest("/api/user/delete", body: {"UserID": LocalDB.getUserID});

  Future<Response> postUpdateAvatar(String userName, String imageSource) =>
      HttpClientHelper().postRequest("/api/user/uploadavatar", body: {
        "UserID": LocalDB.getUserID,
        "UserName": userName,
        "ImagesPaths": imageSource
      });

  Future<Response> getListConfig() =>
      HttpClientHelper().getRequest("/api/config/getlist");
}
