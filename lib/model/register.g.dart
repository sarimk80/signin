// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register()
    ..id = json['id'] as int
    ..token = json['token'] as String;
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
    };
