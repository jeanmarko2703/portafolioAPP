import 'dart:convert';

class User {
    User({
        this.id,
        required this.email,
    });
    String ?id;
    String email;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["EMAIL"],
     
    );

    Map<String, dynamic> toMap() => {
        "EMAIL": email,
    };
}