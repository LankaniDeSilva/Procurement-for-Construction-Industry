// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
