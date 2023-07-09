import 'dart:io';

import 'package:RASEL/Core/utils/constants/network_images.dart';
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
        'cover': AppNetworksImages.coverImage,
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

  late String userTestUid;
  int projectCount = 0;
  int taskCount = 0;

  Future<void> testRegister({
    required TextEditingController emailController,
    required TextEditingController passController,
    required TextEditingController nameController,
  }) async {
    try {
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      CacheHelper.saveData(key: 'test uid', value: value.user!.uid);
      print(value.user!.uid);
      print(CacheHelper.getDate(key: 'test uid'));

      user = FirebaseFirestore.instance
          .collection('users test')
          .doc(value.user!.uid)
          .collection('projects')
          .doc('$projectCount')
          .collection('tasks')
          .doc('$taskCount');

      //add user data
      FirebaseFirestore.instance
          .collection('users test')
          .doc(value.user!.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
      }, SetOptions(merge: true)).then((value) {
        addProject();
      });
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  void addProject() async {
    int x = CacheHelper.getDate(key: 'projectCount') ?? 0;
    x++;
    FirebaseFirestore.instance
        .collection('users test')
        .doc(CacheHelper.getDate(key: 'test uid'))
        .collection('projects')
        .doc(x.toString())
        .set({
      'title': 'project title 2',
      'note': 'project note 2',
      'start date': 'project start date 2',
      'due date': 'project due date 2',
    }, SetOptions(merge: true)).then((value) {
      CacheHelper.saveData(key: 'projectCount', value: x);
      addTask();
    });
  }

  void addTask() async {
    int x = CacheHelper.getDate(key: 'taskCount') ?? 0;
    x++;
    FirebaseFirestore.instance
        .collection('users test')
        .doc(CacheHelper.getDate(key: 'test uid'))
        .collection('projects')
        .doc(CacheHelper.getDate(key: 'projectCount').toString())
        .collection('tasks')
        .doc(x.toString())
        .set({
      'title': 'task title 1',
      'note': 'task note 1',
      'start date': 'task start date 1',
      'end date': 'task end date 1',
    }, SetOptions(merge: true)).then((value) {
      CacheHelper.saveData(key: 'taskCount', value: x);
    });
  }
}
