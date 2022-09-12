class ConfigModel {
  int? configID;
  String? configKey;
  String? configValue;
  int? createdDate;
  int? updatedDate;
  String? userCreated;
  String? userUpdated;

  ConfigModel(
      {this.configID,
      this.configKey,
      this.configValue,
      this.createdDate,
      this.updatedDate,
      this.userCreated,
      this.userUpdated});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    configID = json['ConfigID'];
    configKey = json['ConfigKey'];
    configValue = json['ConfigValue'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
    userCreated = json['UserCreated'];
    userUpdated = json['UserUpdated'];
  }

  static List<ConfigModel> getListConfigResponse(Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <ConfigModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(ConfigModel.fromJson(v));
        });
      }
      return list;
    } else {
      return [];
    }
  }
}
