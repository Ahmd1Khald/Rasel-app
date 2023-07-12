import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/user_model.dart';
import '../../data/repos/repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.homeRepo) : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  final UserRepo homeRepo;
  UserModel? result;

  Future<void> fetchUserData({required String uid}) async {
    emit(UserLoadingFetchUserData());
    var value = await homeRepo.fetchUserData(uid: uid);

    value.fold((failer) {
      emit(UserErrorFetchUserData(failer.errMessage));
    }, (userData) {
      emit(UserSuccessFetchUserData(userData));
      result = userData;
    });
  }

  File? coverPath;
  File? profilePath;
  File? imagePath;
  final imagePicker = ImagePicker();
  String? userImage;
  String? userCover;
  int numImage = 0;

  Future<void> setProfileImage() async {
    //image = null;
    var pickerImage = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(UserLoadingSetProfileState());
    if (pickerImage != null) {
      imagePath = File(pickerImage.path);
      profilePath = imagePath;

      print('picker image => $pickerImage');
      print('path image => ${pickerImage.path}');
      emit(UserSuccessSetProfileState());
    } else {
      emit(UserErrorSetProfileState('Try again latter!'));
    }
  }

  Future<void> setCoverImage() async {
    //image = null;
    var pickerImage = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(UserLoadingSetCoverState());
    if (pickerImage != null) {
      imagePath = File(pickerImage.path);
      coverPath = imagePath;

      print('picker image => $pickerImage');
      print('path image => ${pickerImage.path}');
      emit(UserSuccessSetCoverState());
    } else {
      emit(UserErrorSetCoverState('Try again latter!'));
    }
  }

/*Future<void> setImage(int num) async {
    //image = null;
    var pickerImage = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(UserLoadingUploadPhotoState());
    if (pickerImage != null) {
      imagePath = File(pickerImage.path);
      print('test image => $imagePath');

      if (CacheHelper.getDate(key: 'imagesCounter') == null) {
        uploadImage(numImage: numImage, image: imagePath).then((value) {
          if (num == 1) {
            userCover = value;
            emit(UserSuccessUploadPhotoState());
          }
          if (num == 2) {
            userImage = value;
            emit(UserSuccessUploadPhotoState());
          }
          //image = null;
          numImage++;
          CacheHelper.saveData(key: 'imagesCounter', value: numImage);
          print('image url => $value');
          //userImage = value;
          emit(UserSuccessUploadPhotoState());
        }).catchError((error) {
          emit(UserErrorUploadPhotoState(error.toString()));
          print('error while upload photo $error');
        });
      } else {
        uploadImage(
                numImage: CacheHelper.getDate(key: 'imagesCounter'),
                image: imagePath)
            .then((value) {
          if (num == 1) {
            userCover = value;
            emit(UserSuccessUploadPhotoState());
          }
          if (num == 2) {
            userImage = value;
            emit(UserSuccessUploadPhotoState());
          }
          //image = null;
          int imagesCounter = CacheHelper.getDate(key: 'imagesCounter');
          imagesCounter++;
          CacheHelper.saveData(key: 'imagesCounter', value: imagesCounter);
          print('image url => $value');
          //userImage = value;
          emit(UserSuccessUploadPhotoState());
        }).catchError((error) {
          emit(UserErrorUploadPhotoState(error.toString()));
          print('error while upload photo $error');
        });
      }
    } else {
      emit(UserErrorUploadPhotoState('Try again latter!'));
    }
  }*/
}
