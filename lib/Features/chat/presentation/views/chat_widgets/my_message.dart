import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/constants/fonts_sizes.dart';

class BuiltMyMessage extends StatelessWidget {
  const BuiltMyMessage({
    Key? key,
    required this.backgroundColor,
    required this.msg,
    required this.time,
    required this.year,
    required this.image,
    required this.name,
    required this.phone,
  }) : super(key: key);

  final Color backgroundColor;
  final String msg;
  final String time;
  final String year;
  final String? image;
  final String? name;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.only(
                    right: 16.w, left: 16.w, top: 16.h, bottom: 15.h),
                margin: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32)),
                ),
                child: Text(
                  msg,
                  style: AppStyles.message,
                ),
              ),
            ),
            image != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(image!),
                    radius: AppFontsSize.messageFontSize,
                  )
                : CircleAvatar(
                    backgroundImage: const AssetImage('assets/images/user.png'),
                    radius: AppFontsSize.messageFontSize,
                  ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Text(time),
                        Text(year),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.access_time,
                  size: 19,
                )),
            Text(
              time,
              style: GoogleFonts.aBeeZee(
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
