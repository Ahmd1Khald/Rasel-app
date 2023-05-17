import 'package:chatapp/Features/chat/data/models/user_model.dart';
import 'package:chatapp/Features/chat/data/repos/repo.dart';
import 'package:chatapp/core/errors/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ChatRepoImplement implements ChatRepo {
  @override
  Future<Either<Failure, UserModel>> fetchUserData(
      {required String uid}) async {
    try {
      UserModel userData = const UserModel();
      var snapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null) {
          userData = UserModel.fromJson(data);
          print('userData is $userData');
        }
      }

      //print(userData);
      return right(userData);
    } on FirebaseException catch (e) {
      return left(ServerFailure.fromServerFailureFirebase(e));
    } catch (e) {
      print('++++++++++++++++++++++++');
      print(e);
      return left(ServerFailure('An unexpected error occurred.'));
    }
  }
}
