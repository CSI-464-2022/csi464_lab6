
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class AppUser{
    String firstname;
    String lastname;
    String email;
    String password;
    String username;


    AppUser({
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.password,
        required this.username,
    });

    factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);


}




