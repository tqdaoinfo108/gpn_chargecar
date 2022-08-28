import 'package:charge_car/services/model/parking.dart';
import 'package:charge_car/services/model/user.dart';

class HomeModel {
  UserModel? userModel;
  List<ParkingModel>? listParking;

  HomeModel({this.userModel, this.listParking});
  
}