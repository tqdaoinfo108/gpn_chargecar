import 'package:dio/dio.dart';
import 'http_client.dart';

class RequestBase {}

class HttpClientLocal {
  Future<Response> getProfile(int userID) => HttpClientHelper()
      .getRequest("/api/user/profile", query: {"userID": userID});

  Future<Response> postLogin(String email, String password) =>
      HttpClientHelper().postRequest("/api/user/login",
          body: {"Email": email, "PassWord": password});

  Future<Response> getListChargeCarLocaltion(
          String keySearch, int page, int limit) =>
      HttpClientHelper().getRequest("/api/parkinglot/get",
          query: {"keySearch": keySearch, "page": page, "limit": limit});
}
