import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocalDB {
  LocalDB._();

  static int get getUserID => GetStorage().read("userID") ?? 0;
  static set setUserID(int userID) => GetStorage().write("userID", userID);

  static String get getThemeMode => GetStorage().read("themeMode") ?? "system";
  static set setThemeMode(String themeMode) =>
      GetStorage().write("themeMode", themeMode);

  static String get getLanguagCode => GetStorage().read("locale") ?? "jp";
  static set setLanguageCode(String locale) =>
      GetStorage().write("locale", locale);

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
}
