part of "objects.dart";

@JsonSerializable()
class ItemModel {
  @JsonKey(name: 'itemID')
  String id;
  @JsonKey(name: 'itemName')
  String name;
  @JsonKey(name: 'itemPrice')
  double price;
  @JsonKey(name: 'itemQTY')
  int qty;
  String image;

  ItemModel(this.id, this.name, this.price, this.qty, this.image);

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
