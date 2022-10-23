part of "objects.dart";

@JsonSerializable()
class SiteManager {
  String name;
  String phone;
  String location;
  String uid;
  String img;

  SiteManager(this.name, this.phone, this.location, this.uid, this.img);

  factory SiteManager.fromJson(Map<String, dynamic> json) =>
      _$SiteManagerFromJson(json);

  Map<String, dynamic> toJson() => _$SiteManagerToJson(this);
}
