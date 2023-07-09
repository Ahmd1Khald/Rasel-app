import 'package:RASEL/Core/utils/constants/network_images.dart';
import 'package:RASEL/Core/utils/constants/styles.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/bio_textfield.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/button.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/cover.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/name_textfield.dart';
import 'package:RASEL/Features/layout/presentation/views/users_screen/profile_widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../Core/utils/constants/colors.dart';

class UserEditeProfile extends StatelessWidget {
  const UserEditeProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
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
                    const UserCoverImage(
                      image: AppNetworksImages.coverImage,
                    ),
                    Positioned(
                      bottom: 45,
                      left: 315,
                      child: CircleAvatar(
                        backgroundColor:
                            AppColors.backgroundColor.withOpacity(0.7),
                        child: const Icon(
                          FontAwesomeIcons.camera,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    const UserProfileImage(),
                    Positioned(
                      bottom: 2,
                      left: 190,
                      child: CircleAvatar(
                        backgroundColor:
                            AppColors.backgroundColor.withOpacity(0.7),
                        child: const Icon(
                          FontAwesomeIcons.camera,
                          size: 20,
                          color: Colors.white,
                        ),
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
  }
}
