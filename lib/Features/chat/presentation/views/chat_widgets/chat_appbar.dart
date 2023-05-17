import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../core/utils/constants/assets_images.dart';
import '../../../../../core/utils/constants/styles.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Rasel',
          style: AppStyles.title2,
        ),
        SizedBox(
          width: 5.w,
        ),
        SpinKitSpinningCircle(
          itemBuilder: (BuildContext context, int index) {
            return const DecoratedBox(
              decoration: BoxDecoration(
                //color: index.isEven ? Colors.white : Colors.white.withOpacity(0.5),
                image: DecorationImage(
                  image: AssetImage(AppAssetsImages.logo2Image),
                ),
              ),
            );
          },
          duration: const Duration(milliseconds: 2500),
        ),
        SizedBox(
          width: 100.w,
        )
      ],
    );
  }
}
