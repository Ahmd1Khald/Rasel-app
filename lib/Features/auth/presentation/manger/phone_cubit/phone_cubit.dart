import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/constants/functions.dart';
import '../../../../../core/utils/constants/strings.dart';
import '../../../../../core/utils/constants/variables.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit() : super(PhoneInitial());

  static PhoneCubit get(context) => BlocProvider.of(context);

  void sendOtp({required String phoneNumber}) async {
    emit(PhoneLoadingSendOtpState());
    await AppVariables.firebaseAuth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: '+20$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User user = userCredential.user!;
        AppVariables.phoneAuthId = user.uid;
        print('phone id => ${AppVariables.phoneAuthId}');

        emit(PhoneSuccessSendOtpState());
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle OTP verification failure
        if (e.code == 'invalid-phone-number') {
          // Invalid phone number
          // Handle the error accordingly
          emit(PhoneErrorSendOtpState(e.message!));
          print('Error phone auth ${e.message}');
        } else if (e.code == 'quota-exceeded') {
          // SMS quota exceeded for the project
          // Handle the error accordingly
          emit(PhoneErrorSendOtpState(e.message!));
          print('Error phone auth ${e.message}');
        } else {
          emit(PhoneErrorSendOtpState(e.message!));
          print('Error phone auth ${e.message}');
          // Other OTP verification failures
          // Handle the error accordingly
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        AppVariables.verifiedId = verificationId;
        emit(PhoneSuccessSendOtpState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        AppVariables.verifiedId = verificationId;
      },
    );
  }

  late var user;

  void confirmOtp({required String otpCode}) async {
    emit(PhoneLoadingConfirmOtpState());

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: AppVariables.verifiedId,
        smsCode: otpCode,
      );

      final UserCredential userCredential =
          await AppVariables.firebaseAuth.signInWithCredential(credential);

      user = FirebaseFirestore.instance
          .collection(AppStrings.userCollection)
          .doc(userCredential.user!.uid);

      user.set(({
        'name': userCredential.user!.displayName ?? '',
        'email': userCredential.user!.email ?? '',
        'phone': userCredential.user!.phoneNumber,
        'image': userCredential.user!.photoURL ?? '',
        'createdAt': AppFunctions.dateTimeFormatted('y'),
      }));

      emit(PhoneSuccessConfirmOtpState(userCredential.user!.uid));

      fetchUserData(userCredential.user!.uid);

      // OTP verification successful, do something with the authenticated user
      // For example, you can navigate to a new screen or update the UI accordingly
    } catch (error) {
      // OTP verification failed, handle the error
      emit(PhoneErrorConfirmOtpState(error.toString()));
      print('error while confirm otp => $error');
    }
  }

  Future<void> fetchUserData(String uid) async {
    try {
      print('+++++++++++++++++++++++');
      print(uid);
      print('+++++++++++++++++++++++');
      //01101683770

      FirebaseFirestore.instance
          .collection(AppStrings.userCollection)
          .doc(uid)
          .snapshots()
          .listen((event) {
        print(event.data());
      });
    } catch (e) {
      // Handle any errors that occur during the retrieval
      print('Error retrieving user data: $e');
    }
  }
}
