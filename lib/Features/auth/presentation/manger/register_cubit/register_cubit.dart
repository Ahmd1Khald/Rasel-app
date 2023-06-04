import 'dart:io';

import 'package:RASEL/core/utils/constants/functions.dart';
import 'package:RASEL/core/utils/constants/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helpers/cachehelper.dart';
import '../../../../../core/helpers/upload_user_image_to_firebase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isShowPassIcon = true;
  IconData passIcon = Icons.visibility_off;

  void registerChangePassIcon({
    required bool isShow,
  }) {
    if (isShow) {
      passIcon = Icons.visibility_off;
    } else {
      passIcon = Icons.visibility;
    }
    emit(RegisterChangeObscureIconState());
    isShowPassIcon = !isShow;
  }

  File? imagePath;
  final imagePicker = ImagePicker();
  String? userImage;
  int numImage = 0;

  Future setImage() async {
    //image = null;
    var pickerImage = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(RegisterLoadingUploadPhotoState());
    if (pickerImage != null) {
      imagePath = File(pickerImage.path);
      print('test image => $imagePath');
      if (CacheHelper.getDate(key: 'imagesCounter') == null) {
        uploadImage(numImage: numImage, image: imagePath).then((value) {
          emit(RegisterSuccessUploadPhotoState());
          //image = null;
          numImage++;
          CacheHelper.saveData(key: 'imagesCounter', value: numImage);
          print('image url => $value');
          userImage = value;
        }).catchError((error) {
          emit(RegisterErrorUploadPhotoState(error.toString()));
          print('error while upload photo $error');
        });
      } else {
        uploadImage(
                numImage: CacheHelper.getDate(key: 'imagesCounter'),
                image: imagePath)
            .then((value) {
          emit(RegisterSuccessUploadPhotoState());
          //image = null;
          int imagesCounter = CacheHelper.getDate(key: 'imagesCounter');
          imagesCounter++;
          CacheHelper.saveData(key: 'imagesCounter', value: imagesCounter);
          print('image url => $value');
          userImage = value;
        }).catchError((error) {
          emit(RegisterErrorUploadPhotoState(error.toString()));
          print('error while upload photo $error');
        });
      }
    } else {
      emit(RegisterErrorSetPhotoState('Try again latter!'));
    }
  }

  late var user;

  Future<void> userRegister({
    required TextEditingController emailController,
    required TextEditingController passController,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required String image,
  }) async {
    emit(RegisterLoadingState());
    try {
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      user = FirebaseFirestore.instance
          .collection(AppStrings.userCollection)
          .doc(value.user!.uid);

      user.set(({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passController.text,
        'image': image,
        'bio': 'Write your bio ...',
        'createdAt': AppFunctions.dateTimeFormatted('y'),
      }));

      emit(RegisterSuccessState(value.user!.uid));
      print('user uid =>  ${value.user!.uid}');
    } on FirebaseException catch (e) {
      if (e.code == 'network-request-failed') {
        // Handle network error
        emit(RegisterErrorState(e.message!));
        print('Network error occurred: ${e.message}');
      } else {
        emit(RegisterErrorState(e.message!));
        // Handle other Firebase exceptions
        print('Firebase error occurred: ${e.message}');
      }
    } catch (e) {
      emit(RegisterErrorState('Please try again'));
      // Handle other exceptions
      print('Error occurred: $e');
    }
  }
}
