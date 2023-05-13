import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/constants/assets_images.dart';

class ConfirmOtpImage extends StatelessWidget {
  const ConfirmOtpImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssetsImages.phoneImage,
      fit: BoxFit.cover,
      width: 100.w,
      height: 90.h,
    );
  }
}
