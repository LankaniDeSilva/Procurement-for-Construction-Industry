part of "objects.dart";

@JsonSerializable()
class InventoryModel {
  final String location;
  final String siteName;
  double size;
  final String id;

  InventoryModel(this.location, this.siteName, this.size, this.id);

  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryModelToJson(this);
}
