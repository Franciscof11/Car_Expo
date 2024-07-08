import 'dart:convert';

class User {
  int userId;
  String name;
  String email;
  User({
    required this.userId,
    required this.name,
    required this.email,
  });

  User copyWith({
    int? userId,
    String? name,
    String? email,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'name': name});
    result.addAll({'email': email});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  factory User.empty() {
    return User(
      userId: 0,
      name: '',
      email: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromDatabase(Map<String, dynamic> map) {
    return User(
      userId: map['userId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  @override
  String toString() => 'User(userId: $userId, name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.userId == userId && other.name == name && other.email == email;
  }

  @override
  int get hashCode => userId.hashCode ^ name.hashCode ^ email.hashCode;
}
