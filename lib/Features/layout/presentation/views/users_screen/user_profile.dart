import 'package:RASEL/Core/utils/constants/colors.dart';
import 'package:RASEL/Core/utils/constants/functions.dart';
import 'package:RASEL/Core/utils/constants/network_images.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/bio.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/button.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/cover.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/data.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/line.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/name.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/user_model.dart';
import '../../manger/layout_cubit/layout_cubit.dart';
import '../../manger/layout_cubit/layout_state.dart';
import 'edit_profile.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  UserModel? result;

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is LayoutSuccessFetchUserData) {
          result = state.userData;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            children: [
              SizedBox(
                height: 250.h,
                child: const Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    UserCoverImage(
                      image: AppNetworksImages.coverImage,
                    ),
                    UserProfileImage(),
                  ],
                ),
              ),
              const UserName(),
              SizedBox(
                height: 7.h,
              ),
              const UserBio(),
              const Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 55.0, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserData(type: 'Posts', data: '122'),
                    UserLine(),
                    UserData(type: 'Posts', data: '122'),
                    UserLine(),
                    UserData(type: 'Posts', data: '122'),
                    UserLine(),
                    UserData(type: 'Posts', data: '122'),
                  ],
                ),
              ),
              UserButton(
                title: 'Edit Profile',
                onPressed: () {
                  //cubit.editeProfile();
                  AppFunctions.push(
                    context: context,
                    screen: const UserEditeProfile(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
