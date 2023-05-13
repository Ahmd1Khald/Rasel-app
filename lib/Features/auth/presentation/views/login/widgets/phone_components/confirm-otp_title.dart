import 'package:flutter/material.dart';

import '../../../../../../../core/utils/constants/styles.dart';

class ConfirmOtpTitle extends StatelessWidget {
  const ConfirmOtpTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Enter The code we sent",
      style: AppStyles.title2,
    );
  }
}
