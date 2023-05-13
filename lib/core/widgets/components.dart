import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/cachehelper.dart';
import '../utils/constants/fonts_sizes.dart';

Widget sharedTextField(
        {required textEditingController,
        required Function(String) validation,
        required String label,
        required bool obscure,
        Function()? sufIconFun,
        required IconData prefIcon}) =>
    TextFormField(
      controller: textEditingController,
      validator: (String) => validation(String!),
      obscureText: obscure,
      decoration: InputDecoration(
        label: Text(label),
        suffixIcon: IconButton(
            onPressed: () => sufIconFun!(),
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility)),
        prefixIcon: Icon(prefIcon),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
      ),
    );

void myToast({required var state, required ToastState toastState}) =>
    Fluttertoast.showToast(
        msg: '$state',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: toastColor(toastState),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { success, warning, error }

Color toastColor(ToastState state) {
  Color? color;
  if (state == ToastState.success) {
    color = Colors.green;
  } else if (state == ToastState.warning) {
    color = Colors.amber;
  } else {
    color = Colors.red;
  }
  return color;
}

void showSnachBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

Widget circleLoading({required Color color}) => Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );

Widget builtMyMessage(
        {required Color backgroundColor,
        required String msg,
        required String time,
        required String year,
        required String image}) =>
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.only(
                    right: 16, left: 16, top: 16, bottom: 15),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32)),
                ),
                child: Text(
                  msg,
                  style: GoogleFonts.aBeeZee(
                    fontSize: AppFontsSize.messageFontSize.toDouble(),
                  ),
                ),
              ),
            ),
            CacheHelper.getDate(key: 'photoURL') != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(image),
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

Widget builtFriendsMessage({
  required Color backgroundColor,
  required String msg,
  required String time,
  required String year,
  required String image,
}) =>
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CacheHelper.getDate(key: 'photoURL') != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    radius: AppFontsSize.messageFontSize,
                  )
                : CircleAvatar(
                    backgroundImage: const AssetImage('assets/images/user.png'),
                    radius: AppFontsSize.messageFontSize,
                  ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(
                    right: 16, left: 16, top: 16, bottom: 15),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32)),
                ),
                child: Text(
                  msg,
                  style: GoogleFonts.aBeeZee(
                    fontSize: AppFontsSize.messageFontSize.toDouble(),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
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

void scrollToObject(ScrollController scrollController) {
  scrollController.animateTo(
    0,
    curve: Curves.easeIn,
    duration: const Duration(milliseconds: 500),
  );
}
