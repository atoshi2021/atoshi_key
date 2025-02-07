
class VersionQueryModelDart {
  Version? version;

  VersionQueryModelDart({this.version});

  VersionQueryModelDart.fromJson(Map<String, dynamic> json) {
    version = Version.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (version != null) {
      _data["version"] = version?.toJson();
    }
    return _data;
  }
}

class Version {
  int? id;
  String? appType;
  String? versionNumber;
  String? info;
  String? infoTw;
  String? infoEn;
  String? url;
  String? createTime;
  String? updateTime;

  Version(
      {this.id,
      this.appType,
      this.versionNumber,
      this.info,
      this.infoTw,
      this.infoEn,
      this.url,
      this.createTime,
      this.updateTime});

  Version.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    appType = json["appType"];
    versionNumber = json["versionNumber"];
    info = json["info"];
    infoTw = json["infoTw"];
    infoEn = json["infoEn"];
    url = json["url"];
    createTime = json["createTime"];
    updateTime = json["updateTime"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["appType"] = appType;
    _data["versionNumber"] = versionNumber;
    _data["info"] = info;
    _data["infoTw"] = infoTw;
    _data["infoEn"] = infoEn;
    _data["url"] = url;
    _data["createTime"] = createTime;
    _data["updateTime"] = updateTime;
    return _data;
  }
}
