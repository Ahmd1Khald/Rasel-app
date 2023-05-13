import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/constants/assets_images.dart';
import '../../../../../../core/utils/constants/colors.dart';

class PutUserImage extends StatelessWidget {
  const PutUserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 65.sp,
            backgroundColor: AppColors.lightGrey,
            backgroundImage: const AssetImage(AppAssetsImages.defaultUserImage),
          ),
          /* AppCubit.get(context).image == null
                                ? const CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Colors.grey,
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                  )
                                : CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: FileImage(
                                      AppCubit.get(context).image!,
                                    ),
                                  ),*/
          CircleAvatar(
            backgroundColor: AppColors.lightGrey.withOpacity(0.7),
            radius: 20.sp,
            child: Center(
              child: IconButton(
                onPressed: () {
                  //AppCubit.get(context).setImage();
                },
                icon: Icon(
                  Icons.add_a_photo,
                  size: 22.sp,
                  color: AppColors.green2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
