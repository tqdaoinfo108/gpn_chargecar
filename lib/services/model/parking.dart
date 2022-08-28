import 'package:flutter_map/flutter_map.dart';

import 'response_base.dart';
import 'package:latlong2/latlong.dart';

class ParkingModel {
  double? distance;
  String? unit;
  int? parkingID;
  String? codeParking;
  String? nameParking;
  String? phoneParking;
  String? addressParking;
  double? latParking;
  double? ingParking;
  int? powerSocketAvailable;

  ParkingModel(
      {this.distance,
      this.unit,
      this.parkingID,
      this.codeParking,
      this.nameParking,
      this.phoneParking,
      this.addressParking,
      this.powerSocketAvailable,
      this.ingParking,
      this.latParking});

  LatLng get getLatLng => LatLng(latParking ?? 0, ingParking ?? 0);

  Coords get getCoords => Coords(latParking ?? 0, ingParking ?? 0);

  factory ParkingModel.fromJson(Map<String, dynamic> json) => ParkingModel(
        distance: json['Distance'],
        unit: json['Unit'],
        parkingID: json['ParkingID'],
        codeParking: json['CodeParking'],
        nameParking: json['NameParking'],
        phoneParking: json['PhoneParking'],
        addressParking: json['AddressParking'],
        powerSocketAvailable: json['PowerSocketAvailable'],
        latParking: json["LatParking"],
        ingParking: json["IngParking"],
      );

  static ResponseBase<List<ParkingModel>> getListParkingResponse(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <ParkingModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(ParkingModel.fromJson(v));
        });
      }
      return ResponseBase<List<ParkingModel>>(
        totals: json['totals'],
        data: list,
      );
    } else {
      return ResponseBase(message: json["message"]);
    }
  }
}
