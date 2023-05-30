import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    String id;
    String name;
    String surname;
    String address;

    Users({
        required this.id,
        required this.name,
        required this.surname,
        required this.address,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "address": address,
    };
}