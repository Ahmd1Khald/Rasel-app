import 'package:RASEL/Core/utils/constants/colors.dart';
import 'package:RASEL/Core/utils/constants/functions.dart';
import 'package:RASEL/Features/layout/presentation/manger/layout_cubit/layout_cubit.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/bio.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/button.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/cover.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/data.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/line.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/name.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/widgets/components.dart';
import '../../../../layout/presentation/manger/layout_cubit/layout_state.dart';
import 'edit_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is LayoutLoadingFetchUserData) {
          AppFunctions.loadingPage(context: context);
        }
        if (state is LayoutSuccessFetchUserData) {
          // Navigator.pop(context);
          //myToast(state: 'Done!', toastState: ToastState.success);
        }
        if (state is LayoutErrorFetchUserData) {
          // Navigator.pop(context);
          myToast(state: state.errorMsg, toastState: ToastState.error);
        }
      },
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        // print(
        //   cubit.result!.cover,
        // );
        // print(
        //   cubit.result!.image,
        // );
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            children: [
              SizedBox(
                height: 250.h,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    const UserCoverImage(),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CircleAvatar(
                        radius: 64.sp,
                        backgroundColor: AppColors.backgroundColor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 118.w,
                            height: 108.h,
                            imageUrl: cubit.result!.image!,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: AppColors.lightGrey,
                            ),
                            // Optional: Show a placeholder while loading
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              UserName(
                name: cubit.result?.name!,
              ),
              SizedBox(
                height: 7.h,
              ),
              UserBio(
                bio: cubit.result?.bio!,
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 55.0, bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserData(type: 'Posts', data: '122'),
                    UserLine(),
                    UserData(type: 'Followers', data: '252'),
                    UserLine(),
                    UserData(type: 'Following', data: '22k'),
                    UserLine(),
                    UserData(type: 'Photos', data: '132k'),
                  ],
                ),
              ),
              UserButton(
                title: 'Edit Profile',
                onPressed: () {
                  //cubit.editeProfile();
                  AppFunctions.push(
                    context: context,
                    screen: UserEditeProfile(
                      uid: cubit.userId,
                    ),
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
