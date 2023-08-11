import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  bool validateName() {
    if (name.length > 30 || name == '') {
      return false;
    }
    return true;
  }

  bool validateEmail() {
    if (email.length > 30 || email == '') {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        token: map['token']);
  }

  factory UserModel.fromMapWithToken(Map<String, dynamic> map, String token) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      token: token,
    );
  }

  factory UserModel.fromJson(String jsonData) {
    return UserModel.fromMap(
      json.decode(jsonData),
    );
  }

  String toJson() => json.encode(toMap());
}
