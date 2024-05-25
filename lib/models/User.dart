import 'package:flutter/material.dart';

class User {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? id;
  String? imageAsset;

  User({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.id,
    this.imageAsset,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      country: json['country'],
      id: json['id'],
      imageAsset: json['imageAsset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'id': id,
      'imageAsset': imageAsset,
    };
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, password: $password, phone: $phone, address: $address, city: $city, state: $state, zip: $zip, country: $country,  id: $id}';
  }
}
