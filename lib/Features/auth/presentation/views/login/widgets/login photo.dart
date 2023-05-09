import 'package:flutter/material.dart';

class LoginPhoto extends StatelessWidget {
  const LoginPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/login.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }
}
