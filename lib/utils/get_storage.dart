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
}
