import 'package:RASEL/core/helpers/cachehelper.dart';
import 'package:RASEL/core/utils/constants/keys.dart';
import 'package:RASEL/core/utils/constants/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/repos/repo.dart';
import '../../views/feeds_screen/feeds_screen.dart';
import '../../views/users_screen/users_screen.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;

  Future<void> fetchUserData({required String uid}) async {
    emit(HomeLoadingFetchUserData());
    var result = await homeRepo.fetchUserData(uid: uid);

    result.fold((failer) {
      emit(HomeErrorFetchUserData(failer.errMessage));
    }, (userData) {
      emit(HomeSuccessFetchUserData(userData));
    });
  }

  int currentIndex = 0;

  List<Widget> widgets = [
    const FeedsScreen(),
    const UsersScreen(),
  ];

  void bottomChanged({required int index}) {
    currentIndex = index;

    emit(HomeBottomChangedState());
  }

  final GoogleSignIn gSignIn = GoogleSignIn();

  void logout() async {
    emit(HomeLoadingLogoutState());
    try {
      await gSignIn.signOut();
      CacheHelper.removeData(key: AppKeys.userUid);
      CacheHelper.removeData(key: AppKeys.loginDone);
      AppVariables.userPhoneAuth = false;
      emit(HomeSuccessLogoutState());
    } catch (error) {
      emit(HomeErrorLogoutState(error.toString()));
    }
  }
}
