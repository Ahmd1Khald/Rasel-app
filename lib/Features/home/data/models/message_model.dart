import 'package:RASEL/Features/home/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String? message;
  final String? time;
  final String? year;
  final String? createdAt;
  final UserModel? userData;

  const MessageModel({
    this.message,
    this.time,
    this.year,
    this.createdAt,
    this.userData,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json["message"],
      time: json["time"],
      year: json["year"],
      createdAt: json["createdAt"],
      userData: json["userData"],
    );
  }

  @override
  List<Object?> get props => [
        message,
        time,
        year,
        createdAt,
        userData,
      ];
}
