import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? email;
  final String? image;
  final String? createdAt;
  final String? password;
  final String? phone;

  const UserModel({
    this.name,
    this.email,
    this.image,
    this.createdAt,
    this.password,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      image: json["image"],
      createdAt: json["createdAt"],
      password: json["password"],
      phone: json["phone"],
    );
  }

  @override
  List<Object?> get props => [name, email, image, createdAt, password, phone];
}
