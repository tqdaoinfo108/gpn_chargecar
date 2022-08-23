import 'package:get_storage/get_storage.dart';

class Storage{
  static int get getUserID => GetStorage().read("userID") ?? 0;
  static set  setUserID(int userID) => GetStorage().write("userID", userID);
}