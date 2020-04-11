import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable(nullable: false)
class Register {
  int id; //: 4
  String token;

  Register({this.id, this.token}); //": "QpwL5tke4Pnpja7X4"

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
