import 'dart:io';

import 'package:RASEL/bloc/state.dart';
import 'package:RASEL/core/utils/constants/fonts_sizes.dart';
import 'package:RASEL/core/utils/constants/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/helpers/cachehelper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late CollectionReference user;

  Future<void> registerUser({
    required TextEditingController emailController,
    required TextEditingController passController,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required var image,
  }) async {
    emit(AppLoadingRegisterState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passController.text)
        .then((value) {
      user = FirebaseFirestore.instance.collection('Users');
      CacheHelper.saveData(key: 'userEmail', value: emailController.text);
      //AppVariables.userEmail = emailController.text;
      user
          .add(({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passController.text,
        'image': image,
        'createdAt': DateTime.now(),
      }))
          .then((value) {
        emit(AppSuccessRegisterState());
      }).catchError((error) {
        print('error when register user data ${error.toString()}');
        emit(AppErrorRegisterState());
      });
    }).catchError((error) {
      print('error when user email and password user data ${error.toString()}');
      emit(AppErrorRegisterState());
    });
  }

  late CollectionReference message;

  Future<void> addMessage({
    required TextEditingController messageController,
    required ScrollController scrollController,
    required String email,
    required String image,
  }) async {
    emit(AppLoadingSendMessageState());
    CollectionReference message =
        FirebaseFirestore.instance.collection('Messages');
    message
        .add(({
      'text': messageController.text,
      'time': AppFunctions.dateTimeFormatted('t'),
      'year': AppFunctions.dateTimeFormatted('y'),
      'createdAt': DateTime.now(),
      'userEmail': email,
      'image': image,
    }))
        .then((value) {
      messageController.clear();
      //scrollToObject(scrollController);
      emit(AppSuccessSendMessageState());
    }).catchError((error) {
      emit(AppErrorSendMessageState());
    });
  }

  void logout(context) {
    emit(AppLoadingLogoutState());

    CacheHelper.removeData(key: 'chatPage').then((value) {
      emit(AppSuccessLogoutState());
      //navigateAndRemove(context: context, widget: const LoginScreen());
      CacheHelper.removeData(key: 'userName');
      CacheHelper.removeData(key: 'userEmail');
      CacheHelper.removeData(key: 'photoURL');
      CacheHelper.removeData(key: 'messageFontSize');
    }).catchError((error) {
      print('Error while logout $error');
      emit(AppErrorLogoutState());
    });
  }

  Future saveSettings() async {
    emit(AppLoadingSaveFontSizeState());
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .setInt('messageFontSize', AppFontsSize.messageFontSize.toInt())
        .then((value) {
      emit(AppSuccessSaveFontSizeState());
    }).catchError((error) {
      emit(AppErrorSaveFontSizeState());
    });
  }

  Future getSettings() async {
    emit(AppLoadingGetFontSizeState());
    try {
      final prefs = await SharedPreferences.getInstance();
      AppFontsSize.messageFontSize =
          prefs.getInt('messageFontSize')!.toDouble();
      emit(AppSuccessGetFontSizeState());
    } catch (_) {
      AppFontsSize.messageFontSize = 15;
      emit(AppErrorGetFontSizeState());
    }
  }

  File? image;
  final imagePicker = ImagePicker();
  int numImage = 0;

  Future setImage() async {
    image = null;
    var pickerImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickerImage != null) {
      emit(AppLoadingUploadPhotoState());
      image = File(pickerImage.path);
      uploadImage().then((value) {
        emit(AppSuccessUploadPhotoState());
        image = null;
        numImage++;
      }).catchError((error) {
        emit(AppErrorUploadPhotoState());
        print('error while upload photo $error');
      });
    } else {}
  }

  Future uploadImage() async {
    String path = 'Images/$numImage/chat-app-8a643.appspot.com/';
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask? uploadTask;
    uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    CacheHelper.saveData(key: 'photoURL', value: urlDownload);
    print('Image link:$urlDownload');
  }
}
