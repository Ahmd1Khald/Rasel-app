import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/constants/assets_images.dart';
import '../../../../../../core/utils/constants/colors.dart';

class PutUserImage extends StatelessWidget {
  const PutUserImage({Key? key, required this.image, required this.onPressed})
      : super(key: key);

  final String? image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          image != null
              ? CircleAvatar(
                  radius: 65.sp,
                  backgroundColor: AppColors.lightGrey,
                  backgroundImage: NetworkImage(image!),
                )
              : CircleAvatar(
                  radius: 65.sp,
                  backgroundColor: AppColors.lightGrey,
                  backgroundImage:
                      const AssetImage(AppAssetsImages.defaultUserImage),
                ),
          CircleAvatar(
            backgroundColor: AppColors.lightGrey.withOpacity(0.7),
            radius: 20.sp,
            child: Center(
              child: IconButton(
                onPressed: onPressed,
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
