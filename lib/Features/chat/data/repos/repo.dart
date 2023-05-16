import 'package:chatapp/Features/chat/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class ChatRepo {
  Future<Either<Failure, UserModel>> fetchUserData({required String uid});
}
