import 'package:flutter/material.dart';

class AppPostScreen extends StatelessWidget {
  const AppPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Add Posts'),
      ),
    );
  }
}
