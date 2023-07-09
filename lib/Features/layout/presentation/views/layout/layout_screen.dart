import 'package:RASEL/Features/layout/presentation/views/layout/widgets/layout_widgets/layout_body.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    print('user uid => $uid');
    return LayoutBody(
      uid: uid,
    );
  }
}
