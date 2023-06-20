import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../Core/utils/constants/colors.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        width: double.infinity,
        imageUrl:
            'https://img.freepik.com/free-photo/social-media-concept-with-smartphone_52683-100042.jpg?w=1060&t=st=1686660783~exp=1686661383~hmac=b2aa9ec45ef19106a03a6db3465cca57af29e35c66c964389876d4f4e84fb20e',
        // Replace with your image URL
        placeholder: (context, url) => LinearProgressIndicator(
          color: AppColors.splashBackgroundColor,
          backgroundColor: AppColors.splashBackgroundColor,
        ),
        // Optional: Show a placeholder while loading
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ), // Optional: Show an error icon if the image fails to load
      ),
    );
  }
}
