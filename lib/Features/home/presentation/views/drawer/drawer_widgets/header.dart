import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Core/utils/constants/colors.dart';
import '../../../../../../Core/utils/constants/styles.dart';
import '../../../../../../Core/utils/constants/variables.dart';
import '../../../../data/models/user_model.dart';

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({Key? key, required this.userdata}) : super(key: key);

  final UserModel? userdata;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: AppColors.lightDark,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.lightGrey,
                  ))
            ],
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 50.w,
                  imageUrl: userdata?.image ?? '',
                  // Replace with your image URL
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: AppColors.lightGrey,
                  ),
                  // Optional: Show a placeholder while loading
                  errorWidget: (context, url, error) => const Icon(Icons
                      .error), // Optional: Show an error icon if the image fails to load
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      AppVariables.userPhoneAuth == true
                          ? 'User'
                          : userdata!.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.drawerHeaderStyle,
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      AppVariables.userPhoneAuth == true
                          ? userdata!.phone!
                          : userdata!.email!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.drawerHeaderStyle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
