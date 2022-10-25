part of "objects.dart";

@JsonSerializable()
class ItemModel {
  String id;
  String name;
  String price;
  String qty;
  SupplierModel supplierModel;

  ItemModel(this.id, this.name, this.price, this.qty, this.supplierModel);

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
