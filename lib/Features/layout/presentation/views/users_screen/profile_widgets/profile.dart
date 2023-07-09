import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Core/utils/constants/colors.dart';
import '../../../../../../Core/utils/constants/network_images.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
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
            imageUrl: AppNetworksImages.coverImage,
            placeholder: (context, url) => CircularProgressIndicator(
              color: AppColors.lightGrey,
            ),
            // Optional: Show a placeholder while loading
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
