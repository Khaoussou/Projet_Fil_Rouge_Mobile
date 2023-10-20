import 'dart:core';

class User {
  String nom;
  int id;
  String role;
  String token;
  String telephone;

  User(
      {required this.nom,
      required this.token,
      required this.role,
      required this.id,
      required this.telephone});

  Map<String, dynamic> toJson() => {
        'nom': nom,
        'id': id,
        'role': role,
        'token': token,
        'telephone': telephone
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
      nom: json['nom'],
      id: json['id'],
      role: json['role'],
      token: json['token'],
      telephone: json['telephone']);
}
