// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) =>
    InventoryModel(
      json['location'] as String,
      json['siteName'] as String,
      (json['size'] as num).toDouble(),
      json['id'] as String,
    );

Map<String, dynamic> _$InventoryModelToJson(InventoryModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'siteName': instance.siteName,
      'size': instance.size,
      'id': instance.id,
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
      json['id'] as String,
      json['name'] as String,
      json['price'] as String,
      json['qty'] as String,
      SupplierModel.fromJson(json['supplierModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
      'supplierModel': instance.supplierModel,
    };
