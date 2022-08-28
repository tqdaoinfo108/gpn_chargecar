import 'package:charge_car/utils/const.dart';
import 'package:dio/dio.dart';

class HttpClientHelper {
  late Dio _dio;
  HttpClientHelper() {
    _dio = Dio();
    _dio.options = BaseOptions(
        sendTimeout: Constants.TIME_OUT,
        connectTimeout: Constants.TIME_OUT,
        contentType: "application/json; charset=utf-8",
        baseUrl: Constants.URL_BASE,
        headers: {
          "Authorization": Constants.AUTHORIZATION,
        });
  }

  Future<Response> getRequest(String path,
      {Map<String, dynamic>? query}) async {
    try {
      var response =
          await _dio.get(path, queryParameters: query);
      return response;
    } on DioError catch (_, a) {
      throw Exception(_.message);
    }
  }

  Future<Response> postRequest(String path,
      {Map<String, dynamic>? query, Map<String, dynamic>? body}) async {
    try {
      var response = await _dio.post(path,
          queryParameters: query, data: body);
      return response;
    } on DioError catch (_, a) {
      throw Exception(_.message);
    }
  }
}
