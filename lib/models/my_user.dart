import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/models/Model.dart';

part 'my_user.g.dart';

@JsonSerializable()
class MyUser implements Model {
  final String? id;
  final String? email;
  late final String? fullName;
  final String? mobile;
  final String? dob;
  final String? password;
  final bool? isActive;
  final String? role;
  late final List<Map<String, String>>? addresses;
  late final String? avatar;

  MyUser({
    this.id,
    this.email,
    this.fullName,
    this.mobile,
    this.dob,
    this.password,
    this.isActive,
    this.role,
    this.addresses,
    this.avatar,
  });

  dynamic getValue(String key) {
    switch (key) {
      case 'fullName':
        return fullName;
      case 'email':
        return email;
      case 'mobile':
        return mobile;
      case 'dob':
        return dob;
      default:
        return null;
    }
  }


  @override
  String toString() {
    return 'MyUser{id: $id, email: $email, fullName: $fullName, mobile: $mobile, dob: $dob, password: $password, isActive: $isActive, role: $role, addresses: $addresses, avatar: $avatar}';
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return _$MyUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
