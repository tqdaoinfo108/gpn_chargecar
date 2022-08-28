import 'dart:convert';

import 'package:charge_car/services/model/response_base.dart';

class UserModel {
  int? userID;
  String? imagesPaths;
  int? typeUserID;
  String? uUserID;
  String? fullName;
  String? email;
  String? phone;
  int? status;
  int? confirmEmail;
  String? lastLogin;
  String? languageCode;

  UserModel(
      {userID,
      imagesPaths,
      typeUserID,
      uUserID,
      fullName,
      email,
      phone,
      status,
      confirmEmail,
      lastLogin,
      languageCode});

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    imagesPaths = json['ImagesPaths'];
    typeUserID = json['TypeUserID'];
    uUserID = json['UUserID'];
    fullName = json['FullName'];
    email = json['Email'];
    phone = json['Phone'];
    status = json['Status'];
    confirmEmail = json['ConfirmEmail'];
    lastLogin = json['LastLogin'];
    languageCode = json['LanguageCode'];
  }
  static ResponseBase<UserModel> getUserResponse(Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<UserModel>(data: UserModel.fromJson(json["data"]));
    } else {
      return ResponseBase(message: json["message"]);
    }
  }
}
