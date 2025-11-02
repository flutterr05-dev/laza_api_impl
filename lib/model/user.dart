
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final String? firstName;
    final String? username;
    final String? email;
    final String? password;

    User({
        this.firstName,
        this.username,
        this.email,
        this.password,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "username": username,
        "email": email,
        "password": password,
    };
}
