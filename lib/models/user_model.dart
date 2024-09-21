import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String profilepic;
  final String name;
  final String email;
  final String uid;
  final String token;
  UserModel({
    required this.profilepic,
    required this.name,
    required this.email,
    required this.uid,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilepic': profilepic,
      'name': name,
      'email': email,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profilepic: map['profilepic'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? profilepic,
    String? name,
    String? email,
    String? uid,
    String? token,
  }) {
    return UserModel(
      profilepic: profilepic ?? this.profilepic,
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
