import 'package:chatapp/bloc/state.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/cachehelper.dart';
import '../shared/const.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late CollectionReference user;

  Future<void> registerUser({
    required TextEditingController emailController,
    required TextEditingController passController,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) async {
    emit(AppLoadingRegisterState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passController.text)
        .then((value) {
      user = FirebaseFirestore.instance.collection('Users');
      CacheHelper.saveData(key: 'userEmail', value: emailController.text);
      userEmail = emailController.text;

      user
          .add(({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passController.text,
        'createdAt': DateTime.now(),
      }))
          .then((value) {
        emit(AppSuccessRegisterState());
      }).catchError((error) {
        print('error when insert user data ${error.toString()}');
        emit(AppErrorRegisterState());
      });
    }).catchError((error) {
      print('error when user email and password user data ${error.toString()}');
      emit(AppErrorRegisterState());
    });
  }

  Future<void> loginUser(TextEditingController emailController,
      TextEditingController passController) async {
    emit(AppLoadingLoginState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passController.text)
        .then((value) {
      userEmail = emailController.text;
      CacheHelper.saveData(key: 'userEmail', value: emailController.text);
      emit(AppSuccessLoginState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorLoginState());
    });
  }

  late CollectionReference message;

  Future<void> addMessage({
    required TextEditingController messageController,
    required ScrollController scrollController,
    required String email,
  }) async {
    emit(AppLoadingSendMessageState());
    CollectionReference message =
        FirebaseFirestore.instance.collection('Messages');
    message
        .add(({
      'text': messageController.text,
      'time': date('t'),
      'year': date('y'),
      'createdAt': DateTime.now(),
      'userEmail': email,
    }))
        .then((value) {
      messageController.clear();
      scrollToObject(scrollController);
      emit(AppSuccessSendMessageState());
    }).catchError((error) {
      emit(AppErrorSendMessageState());
    });
  }

  void logout(context) {
    emit(AppLoadingLogoutState());
    CacheHelper.removeData(key: 'userEmail');
    CacheHelper.removeData(key: 'userName');
    CacheHelper.removeData(key: 'chatPage').then((value) {
      emit(AppSuccessLogoutState());
      navigateAndRemove(context: context, widget: const LoginScreen());
    }).catchError((error) {
      print('Error while logout $error');
      emit(AppErrorLogoutState());
    });
  }
}
