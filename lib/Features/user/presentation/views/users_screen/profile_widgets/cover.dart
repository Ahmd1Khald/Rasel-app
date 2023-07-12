import 'package:RASEL/Core/utils/constants/network_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../Core/utils/constants/colors.dart';

class UserCoverImage extends StatelessWidget {
  const UserCoverImage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: double.infinity,
          imageUrl: AppNetworksImages.coverImage,
          // Replace with your image URL
          placeholder: (context, url) => LinearProgressIndicator(
            color: AppColors.lightGrey,
            backgroundColor: AppColors.sidesColor,
          ),
          // Optional: Show a placeholder while loading
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error),
          ), // Optional: Show an error icon if the image fails to load
        ),
      ),
    );
  }
}
