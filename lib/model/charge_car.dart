import 'package:latlong2/latlong.dart';

class ChargeCarModel {
  String? name;
  String? bettwen;
  String? address;
  LatLng? latLng;

  ChargeCarModel(this.name, this.bettwen, this.latLng,this.address);

  static List<ChargeCarModel> getList() {
    return [
      ChargeCarModel("GPN Charge car", "11 Km", LatLng(10.780231, 106.6645121),"458 Lê Văn Sỹ, Phường 2, Tân Bình, Thành phố Hồ Chí Minh 700000, Việt Nam"),
      ChargeCarModel("GPN ADVANTECH COMPANY LIMITED", "12 Km",
          LatLng(10.8032723, 106.6630206),"10 Phan Đình Giót, Phường 2, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam"),
      ChargeCarModel(
          "My Home charge", "0,4 Km", LatLng(10.8025611, 106.6662756),"VQCR+GP6, Khu Phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam"),
      ChargeCarModel("Bãi giữ xe Trung Tâm Hội Chợ Triển Lãm Tân Bình",
          "22,4 Km", LatLng(10.7968396, 106.6583101),"QMV3+VQ7, Hoàng Văn Thụ, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam"),
    ];
  }
}
