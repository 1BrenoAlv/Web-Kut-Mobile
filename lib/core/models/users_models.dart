import 'dart:convert';

UsersModels usersModelsFromJson(String str) =>
    UsersModels.fromJson(json.decode(str)); // converte de string JSON para OBJ

String usersModelsToJson(UsersModels data) =>
    json.encode(data.toJson()); // de OBJ para JSON

class UsersModels {
  final int id;
  String name;
  String username;
  String email;

  UsersModels({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory UsersModels.fromJson(Map<String, dynamic> json) => UsersModels(
    // pega info do DB
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    // envia info para DB
    "id": id,
    "name": name,
    "username": username,
    "email": email,
  };
}
