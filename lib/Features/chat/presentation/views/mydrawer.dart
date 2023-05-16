import 'package:chatapp/Features/chat/presentation/manger/chat_cubit/chat_cubit.dart';
import 'package:chatapp/core/helpers/cachehelper.dart';
import 'package:chatapp/core/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/variables.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Drawer(
            backgroundColor: AppColors.deepDark,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300.h,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.dark,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: AppColors.lightGrey,
                            backgroundImage: NetworkImage(
                                CacheHelper.getDate(key: 'photoURL')),
                            radius: 55.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "No Email yet..",
                          maxLines: 1,
                          style: AppStyles.title3,
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: AppColors.lightDark,
                  ),
                  title: const Text(
                    'Settings',
                  ),
                  onTap: () {
                    //navigateTo(context, const SettingScreen());
                    /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));*/
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.share,
                    color: AppColors.lightDark,
                  ),
                  title: const Text(
                    'Share',
                  ),
                  onTap: () {
                    Share.share(
                        '''*Chat app*\nU can develop it from my github https://github.com/Ahmd1Khald/chat_app ''');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.rate_review,
                    color: AppColors.lightDark,
                  ),
                  title: const Text(
                    'Rate',
                  ),
                  onTap: () async {
                    if (!await launchUrl(AppVariables.appUrl,
                        mode: LaunchMode.externalApplication)) {
                      throw 'Could not launch ${AppVariables.appUrl}';
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.login,
                    color: AppColors.lightDark,
                  ),
                  title: const Text(
                    'Logout',
                  ),
                  onTap: () {
                    //AppCubit.get(context).logout(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
