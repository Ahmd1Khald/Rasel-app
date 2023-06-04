import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/repo_implement.dart';
import '../../manger/home_cubit/home_cubit.dart';
import '../../manger/home_cubit/home_state.dart';
import 'home_widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.uid}) : super(key: key);

  final String uid;
  var result;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(HomeRepoImplement())..fetchUserData(uid: uid),
      child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return const HomeBody();
          }),
    );
  }
}
