import 'package:RASEL/core/utils/constants/assets_images.dart';
import 'package:flutter/material.dart';

class LoginPhoto extends StatelessWidget {
  const LoginPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssetsImages.loginImage,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }
}
