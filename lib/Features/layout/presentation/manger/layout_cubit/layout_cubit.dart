import 'package:RASEL/core/helpers/cachehelper.dart';
import 'package:RASEL/core/utils/constants/keys.dart';
import 'package:RASEL/core/utils/constants/variables.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../user/presentation/views/users_screen/user_profile.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repos/repo.dart';
import '../../views/feeds_screen/feeds_screen.dart';
import '../../views/layout/widgets/layout_widgets/add_post.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit(this.homeRepo) : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  final LayoutRepo homeRepo;
  late String userId;
  UserModel? result;

  Future<void> fetchUserData({required String uid}) async {
    userId = uid;
    emit(LayoutLoadingFetchUserData());
    var value = await homeRepo.fetchUserData(uid: uid);

    value.fold((failer) {
      emit(LayoutErrorFetchUserData(failer.errMessage));
    }, (userData) {
      emit(LayoutSuccessFetchUserData(userData));
      result = userData;
    });
  }

  int currentIndex = 0;

  var widgets = [
    const FeedsScreen(),
    const AppPostScreen(),
    UserProfile(uid: CacheHelper.getDate(key: AppKeys.userUid)),
  ];

  void bottomChanged({
    required int index,
  }) {
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
