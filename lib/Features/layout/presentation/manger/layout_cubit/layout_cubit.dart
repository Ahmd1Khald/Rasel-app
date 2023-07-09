import 'package:RASEL/Features/layout/presentation/views/users_screen/user_profile.dart';
import 'package:RASEL/core/helpers/cachehelper.dart';
import 'package:RASEL/core/utils/constants/keys.dart';
import 'package:RASEL/core/utils/constants/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/repos/repo.dart';
import '../../views/feeds_screen/feeds_screen.dart';
import '../../views/layout/widgets/layout_widgets/add_post.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit(this.homeRepo) : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  final LayoutRepo homeRepo;

  Future<void> fetchUserData({required String uid}) async {
    emit(LayoutLoadingFetchUserData());
    var result = await homeRepo.fetchUserData(uid: uid);

    result.fold((failer) {
      emit(LayoutErrorFetchUserData(failer.errMessage));
    }, (userData) {
      emit(LayoutSuccessFetchUserData(userData));
    });
  }

  int currentIndex = 0;

  List<Widget> widgets = [
    const FeedsScreen(),
    const AppPostScreen(),
    UserProfile(),
  ];

  void bottomChanged({required int index}) {
    if (index == 1) {
      emit(LayoutAddPostsState());
    } else {
      currentIndex = index;
      emit(LayoutBottomChangedState());
    }
  }

  final GoogleSignIn gSignIn = GoogleSignIn();

  void logout() async {
    emit(LayoutLoadingLogoutState());
    try {
      await gSignIn.signOut();
      CacheHelper.removeData(key: AppKeys.userUid);
      CacheHelper.removeData(key: AppKeys.loginDone);
      CacheHelper.removeData(key: AppKeys.userPhoneAuth);
      AppVariables.userPhoneAuth = false;
      emit(LayoutSuccessLogoutState());
    } catch (error) {
      emit(LayoutErrorLogoutState(error.toString()));
    }
  }
}
