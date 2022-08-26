import 'package:get/get_connect.dart';

import '../utils/const.dart';

class RequestBase {
  
}

class HttpClient extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.URL_BASE;
    httpClient.timeout = const Duration(milliseconds: Constants.TIME_OUT);
    httpClient.addResponseModifier<RequestBase>((request, response) {
      CasesModel model = response.body;
      if (model.countries.contains('Brazil')) {
        model.countries.remove('Brazilll');
      }
    });
  }
  
}
