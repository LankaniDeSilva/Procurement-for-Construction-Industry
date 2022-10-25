part of "objects.dart";

@JsonSerializable()
class SupplierModel {
  String name;
  String address;
  String contactnumber;
  String location;


  SupplierModel(this.name, this.address, this.contactnumber, this.location);

  factory SupplierModel.fromJson(Map<String, dynamic> json) =>
      _$SupplierModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierModelToJson(this);
}
