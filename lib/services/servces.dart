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
          String keySearch, int page, int limit) =>
      HttpClientHelper().getRequest("/api/parkinglot/get",
          query: {"keySearch": keySearch, "page": page, "limit": limit});

  Future<Response> getListNotification(int page) =>
      HttpClientHelper().getRequest("/api/notification/getlist", query: {
        "userID": LocalDB.getUserID,
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
}
