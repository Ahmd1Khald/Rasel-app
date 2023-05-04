import 'package:chatapp/Features/start/presentation/views/widgets/loading_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.appColor,
      body: LoadingBody(),
    );
  }
}
