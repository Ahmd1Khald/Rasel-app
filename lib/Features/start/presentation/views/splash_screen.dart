import 'package:chatapp/Features/start/presentation/views/widgets/splash_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}
