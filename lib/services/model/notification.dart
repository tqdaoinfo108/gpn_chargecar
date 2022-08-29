import 'package:charge_car/services/model/response_base.dart';

class NotificationModel {
  int? notificationId;
  int? typeId;
  int? id;
  String? title;
  String? message;
  int? createdDate;
  String? userCreated;

  NotificationModel(
      {notificationId, typeId, id, title, message, createdDate, userCreated});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = json["NotificationID"];
    typeId = json["TypeID"];
    id = json["ID"];
    title = json["Title"];
    message = json["Message"];
    createdDate = json["CreatedDate"];
    userCreated = json["UserCreated"];
  }

  static ResponseBase<List<NotificationModel>> getListNotificationResponse(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <NotificationModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(NotificationModel.fromJson(v));
        });
      }
      return ResponseBase<List<NotificationModel>>(
        totals: json['totals'],
        data: list,
      );
    } else {
      return ResponseBase(message: json["message"]);
    }
  }
}
