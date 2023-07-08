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
            'https://img.freepik.com/free-photo/young-handsome-man-chekered-shirt-sitting-table-using-tablet-computer-co-working-office_285396-9051.jpg?w=1060&t=st=1688827354~exp=1688827954~hmac=4f8b7c1d81a353feacdcb3885a6bc784bd361143c545d41c9e44e6cf40756697',
        // Replace with your image URL
        placeholder: (context, url) => LinearProgressIndicator(
          color: AppColors.lightGrey,
          backgroundColor: AppColors.midDark,
        ),
        // Optional: Show a placeholder while loading
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ), // Optional: Show an error icon if the image fails to load
      ),
    );
  }
}
