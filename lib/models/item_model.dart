part of "objects.dart";

@JsonSerializable()
class ItemModel {
  @JsonKey(name: 'itemID')
  String id;
  @JsonKey(name: 'itemName')
  String name;
  @JsonKey(name: 'itemPrice')
  String price;
  @JsonKey(name: 'itemQTY')
  String qty;

  ItemModel(this.id, this.name, this.price, this.qty);

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
