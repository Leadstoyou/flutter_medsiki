// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      mobile: json['mobile'] as String?,
      dob: json['dob'] as String?,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool?,
      role: json['role'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'mobile': instance.mobile,
      'dob': instance.dob,
      'password': instance.password,
      'isActive': instance.isActive,
      'role': instance.role,
      'addresses': instance.addresses,
      'avatar': instance.avatar,
    };
