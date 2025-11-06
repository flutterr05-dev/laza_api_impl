// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final String? firstName;
    final String? email;
    final String? phone;
    final String? country;
    final String? city;
    final String? address;
    final String? image;

    User({
        this.firstName,
        this.email,
        this.phone,
        this.country,
        this.city,
        this.address,
        this.image,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        email: json["email"],
        phone: json["phone"],
        country: json["country"],
        city: json["city"],
        address: json["address"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "email": email,
        "phone": phone,
        "country": country,
        "city": city,
        "address": address,
        "image": image,
    };
}
