class User {
  int? id;
  String? uid;
  String? username;
  String? phoneNumber;
  String? email;

  User({
    this.id,
    this.uid,
    this.username,
    this.phoneNumber,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone_number': phoneNumber,
      'email': email,
    };
  }

  User.fromData(String uid) {
    this.uid = uid;
  }
}
