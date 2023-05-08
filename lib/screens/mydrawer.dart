import 'package:chatapp/core/helpers/cachehelper.dart';
import 'package:chatapp/screens/settings.dart';
import 'package:chatapp/core/widgets/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
import '../core/utils/constants/colors.dart';
import '../core/utils/constants/variables.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('Users');
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: user.orderBy('createdAt', descending: true).snapshots(),
            builder: (context, snapshot) {
              // print(CacheHelper.getDate(key: 'userEmail'));
              // print(CacheHelper.getDate(key: 'userName'));
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.hasData) {
                return Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                        ),
                        child: Column(
                          children: [
                            CacheHelper.getDate(key: 'photoURL') != null
                                ? CircleAvatar(
                                    backgroundColor: Colors.green[200],
                                    backgroundImage: NetworkImage(
                                        CacheHelper.getDate(key: 'photoURL')),
                                    radius: 45,
                                  )
                                : const CircleAvatar(
                                    //backgroundColor: Colors.green[200],
                                    radius: 45,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            /*Text(
                              userEmail.isNotEmpty
                                  ? userEmail
                                  : "No Email yet..",
                              maxLines: 1,
                              style: GoogleFonts.aclonica(
                                fontSize: 13,
                              ) */ /*const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        )*/ /*
                              ,
                            )*/
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.settings,
                        ),
                        title: const Text(
                          'Settings',
                        ),
                        onTap: () {
                          navigateTo(context, const SettingScreen());
                          /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));*/
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.share,
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
                        leading: const Icon(
                          Icons.rate_review,
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
                        leading: const Icon(
                          Icons.login,
                        ),
                        title: const Text(
                          'Logout',
                        ),
                        onTap: () {
                          AppCubit.get(context).logout(context);
                        },
                      ),
                      if (state is AppLoadingLogoutState)
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColors.backgroundColor,
                          ),
                        )
                    ],
                  ),
                );
              }
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green[200],
                            backgroundImage: NetworkImage(
                                CacheHelper.getDate(key: 'photoURL')),
                            radius: 45,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppVariables.userEmail.isNotEmpty ? AppVariables.userEmail : "No Email yet..",
                            maxLines: 1,
                            style: GoogleFonts.aclonica(
                              fontSize: 13,
                            ) /*const TextStyle(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                        )*/
                            ,
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings,
                      ),
                      title: const Text(
                        'Settings',
                      ),
                      onTap: () {
                        navigateTo(context, const SettingScreen());
                        /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));*/
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.share,
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
                      leading: const Icon(
                        Icons.rate_review,
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
                      leading: const Icon(
                        Icons.login,
                      ),
                      title: const Text(
                        'Logout',
                      ),
                      onTap: () {
                        AppCubit.get(context).logout(context);
                      },
                    ),
                    if (state is AppLoadingLogoutState)
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.backgroundColor,
                        ),
                      )
                  ],
                ),
              );
            },
          );
        });
  }
}
