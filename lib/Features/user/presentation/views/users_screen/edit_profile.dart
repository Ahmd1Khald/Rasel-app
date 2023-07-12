import 'package:RASEL/Core/utils/constants/styles.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/bio_textfield.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/button.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/cover.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/name_textfield.dart';
import 'package:RASEL/Features/user/presentation/views/users_screen/profile_widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../Core/utils/constants/colors.dart';
import '../../../../../Core/utils/constants/functions.dart';
import '../../../../../Core/widgets/components.dart';
import '../../../../user/presentation/manger/user_cubit.dart';

class UserEditeProfile extends StatelessWidget {
  const UserEditeProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    UserCubit cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoadingSetProfileState) {
          AppFunctions.loadingPage(context: context);
        }
        if (state is UserSuccessSetProfileState) {
          Navigator.pop(context);
          myToast(state: 'Done!', toastState: ToastState.success);
        }
        if (state is UserErrorSetProfileState) {
          Navigator.pop(context);
          myToast(state: state.errorMsg, toastState: ToastState.error);
        }
      },
      builder: (context, state) {
        // print(
        //   cubit.result!.cover,
        // );
        // print(
        //   cubit.result!.image,
        // );

        nameController.text = cubit.result!.name!;
        bioController.text = cubit.result!.bio!;
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.sidesColor,
            title: Text(
              'Edite Profile',
              style: AppStyles.title3,
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 250.h,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Stack(
                      children: [
                        const UserCoverImage(),
                        Positioned(
                          bottom: 230.sp,
                          left: 315.sp,
                          child: CircleAvatar(
                              backgroundColor:
                                  AppColors.backgroundColor.withOpacity(0.7),
                              child: IconButton(
                                onPressed: () {
                                  cubit.setCoverImage();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        UserProfileImage(
                          image: cubit.profilePath,
                        ),
                        Positioned(
                          bottom: 2.sp,
                          left: 190.sp,
                          child: CircleAvatar(
                            backgroundColor:
                                AppColors.backgroundColor.withOpacity(0.7),
                            child: IconButton(
                                onPressed: () {
                                  cubit.setProfileImage();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.camera,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              UserNameTextField(
                nameController: nameController,
              ),
              UserBioTextField(
                bioController: bioController,
              ),
              SizedBox(
                height: 25.h,
              ),
              UserButton(
                title: 'Update',
                onPressed: () {
                  //cubit.editeProfile();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
