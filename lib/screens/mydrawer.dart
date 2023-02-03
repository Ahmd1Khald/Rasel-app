import 'package:chatapp/local/cachehelper.dart';
import 'package:chatapp/shared/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/cubit.dart';
import '../bloc/state.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  CollectionReference user = FirebaseFirestore.instance.collection('Users');

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: mainColor,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        height: 90,
                      ),
                      Text(
                        userEmail.isNotEmpty
                            ? userEmail
                            : "No Email yet..",
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20, overflow: TextOverflow.ellipsis),
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
                    Navigator.pop(context);
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
                    Share.share('''*Chat app*\n
              u can develop it from my github github.com/Ahmd1Khald ''');
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
                    if (!await launchUrl(appUrl,
                        mode: LaunchMode.externalApplication)) {
                      throw 'Could not launch $appUrl';
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
                      color: mainColor,
                    ),
                  )
              ],
            ),
          );
        });
  }
}
