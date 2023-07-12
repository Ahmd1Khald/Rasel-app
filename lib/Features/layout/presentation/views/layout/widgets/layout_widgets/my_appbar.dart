import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../../Core/utils/constants/colors.dart';
import '../../../../../../../Core/utils/constants/functions.dart';
import '../../../../../../../Core/utils/constants/styles.dart';
import '../../../chat/chat_screen.dart';

PreferredSizeWidget myAppBar(context) => AppBar(
      backgroundColor: AppColors.sidesColor,
      title: SpinKitSpinningCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Rasel',
                style: AppStyles.title3,
              ),
            ),
          );
        },
        duration: const Duration(milliseconds: 9500),
      ),
      actions: [
        IconButton(
          onPressed: () {
            ///todo notification screen
          },
          icon: const Icon(
            Icons.notifications,
          ),
        ),
        IconButton(
          onPressed: () {
            AppFunctions.push(
              context: context,
              screen: const ChatScreen(),
            );
          },
          icon: const Icon(
            Icons.chat_bubble,
          ),
        ),
      ],
    );
