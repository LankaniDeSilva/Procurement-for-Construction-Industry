// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      total: (json['total'] as num).toDouble(),
      items: (json['item'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderState: json['orderState'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.userModel.toJson(),
      'total': instance.total,
      'item': instance.items.map((e) => e.toJson()).toList(),
      'orderState': instance.orderState,
    };

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      cartId: json['cartId'] as String,
      qty: json['qty'] as int,
      subTotal: (json['subTotal'] as num).toDouble(),
      model: ItemModel.fromJson(json['model'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'cartId': instance.cartId,
      'qty': instance.qty,
      'subTotal': instance.subTotal,
      'model': instance.model.toJson(),
    };

InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) =>
    InventoryModel(
      json['location'] as String,
      json['itemName'] as String,
      json['qty'] as int,
      InventoryModel._dateTimeFromTimestamp(json['date'] as Timestamp),
      json['id'] as String,
    );

Map<String, dynamic> _$InventoryModelToJson(InventoryModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'itemName': instance.itemName,
      'qty': instance.qty,
      'id': instance.id,
      'date': InventoryModel._dateTimeAsIs(instance.date),
    };

SiteManager _$SiteManagerFromJson(Map<String, dynamic> json) => SiteManager(
      json['name'] as String,
      json['phone'] as String,
      json['location'] as String,
      json['uid'] as String,
      json['img'] as String,
    );

Map<String, dynamic> _$SiteManagerToJson(SiteManager instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'location': instance.location,
      'uid': instance.uid,
      'img': instance.img,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['uid'] as String,
      json['name'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uid': instance.uid,
    };

SupplierModel _$SupplierModelFromJson(Map<String, dynamic> json) =>
    SupplierModel(
      json['name'] as String,
      json['address'] as String,
      json['contactnumber'] as String,
      json['location'] as String,
    );

Map<String, dynamic> _$SupplierModelToJson(SupplierModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'contactnumber': instance.contactnumber,
      'location': instance.location,
    };

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      json['itemID'] as String,
      json['itemName'] as String,
      (json['itemPrice'] as num).toDouble(),
      json['itemQTY'] as int,
      json['image'] as String,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'itemID': instance.id,
      'itemName': instance.name,
      'itemPrice': instance.price,
      'itemQTY': instance.qty,
      'image': instance.image,
    };
