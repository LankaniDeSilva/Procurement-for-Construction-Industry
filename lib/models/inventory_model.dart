part of "objects.dart";

@JsonSerializable()
class InventoryModel {
  final String location;
  final String itemName;
  int qty;
  final String id;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  DateTime date;

  InventoryModel(this.location, this.itemName, this.qty, this.date, this.id);

  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryModelToJson(this);

  static DateTime _dateTimeAsIs(DateTime dateTime) => dateTime;

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }
}
