import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    required this.username,
    required this.lastname,
  });

  final String? id;
  final String username;
  final String lastname;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'lastname': lastname,
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? lastname,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      lastname: lastname ?? this.lastname,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String?,
      username: map['username'] as String,
      lastname: map['lastname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      "$runtimeType(id: $id, username: $username, lastname: $lastname)";
}
