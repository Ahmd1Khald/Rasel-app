import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/user_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, UserModel>> fetchUserData({required String uid});
}
