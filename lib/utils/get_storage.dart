import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalDB {
  LocalDB._();

  static int get getUserID => GetStorage().read("userID") ?? 0;
  static set setUserID(int userID) => GetStorage().write("userID", userID);

  static String get getThemeMode => GetStorage().read("themeMode") ?? "system";
  static set setThemeMode(String themeMode) =>
      GetStorage().write("themeMode", themeMode);

  static String get getLanguagCode => getLocalionDefaul();
  static set setLanguageCode(String locale) =>
      GetStorage().write("locale", locale);

  static String getLocalionDefaul() {
    if (GetStorage().read("locale") == null) {
      var location = Get.deviceLocale;
      if (location != null) {
        if (location.languageCode == "en") {
          setLanguageCode = "en";
          return "en";
        } else {
          setLanguageCode = "jp";
          return "jp";
        }
      }
    }
    return GetStorage().read("locale") ?? "jp";
  }

  static String get getMqttServer =>
      GetStorage().read("MQTT_server") ?? "gpn-advance-tech.com";
  static set setMqttServer(String server) =>
      GetStorage().write("MQTT_server", server);

  static int get getMqttPort => GetStorage().read("MQTT_Port") ?? 1883;
  static set setMqttPort(int port) => GetStorage().write("MQTT_Port", port);

  static String get getMqttUserName =>
      GetStorage().read("MQTT_UserName") ?? "gdev";
  static set setMqttUserName(String userName) =>
      GetStorage().write("MQTT_UserName", userName);

  static String get getMqttPassword =>
      GetStorage().read("MQTT_Password") ?? "gdev12345";
  static set setMqttPassword(String password) =>
      GetStorage().write("MQTT_Password", password);

  static String get getLastLogin => GetStorage().read("LastLogin") ?? "0";
  static set setLastLogin(String lastLogin) =>
      GetStorage().write("LastLogin", lastLogin);

  static String get getUUID => GetStorage().read("UUID") ?? "0";
  static set setUUID(String uUID) => GetStorage().write("UUID", uUID);

  static bool get isDebug => GetStorage().read("isDebug") == "true";
  static set setIsDebug(String debug) => GetStorage().write("isDebug", debug);
}
