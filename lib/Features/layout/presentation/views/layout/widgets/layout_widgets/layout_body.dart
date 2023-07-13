import 'package:RASEL/Core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../Core/utils/constants/functions.dart';
import '../../../../../data/repos/repo_implement.dart';
import '../../../../manger/layout_cubit/layout_cubit.dart';
import '../../../../manger/layout_cubit/layout_state.dart';
import '../../../drawer/mydrawer.dart';
import 'add_post.dart';
import 'my_appbar.dart';

class LayoutBody extends StatelessWidget {
  const LayoutBody({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LayoutCubit(
              LayoutRepoImplement(),
            )..fetchUserData(uid: uid),
        child: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {
            if (state is LayoutAddPostsState) {
              AppFunctions.push(
                context: context,
                screen: const AppPostScreen(),
              );
            }
          },
          builder: (context, state) {
            print('result => ${LayoutCubit.get(context).result}');
            //LayoutCubit cubit = LayoutCubit.get(context);
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: myAppBar(context),
              bottomNavigationBar: myBottomNavBar(context: context),
              drawer: MyDrawer(
                userdata: LayoutCubit.get(context).result,
              ),
              body: LayoutCubit.get(context)
                  .widgets[LayoutCubit.get(context).currentIndex],
            );
          },
        ));
  }
}

Widget myBottomNavBar({required context}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: BottomNavigationBar(
        backgroundColor: AppColors.sidesColor!,
        currentIndex: LayoutCubit.get(context).currentIndex,
        onTap: (index) {
          LayoutCubit.get(context).bottomChanged(index: index);

          print(LayoutCubit.get(context).currentIndex);
        },
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.houseChimney,
              ),
            ),
            label: 'Layout',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.circlePlus,
              ),
            ),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.solidUser,
              ),
            ),
            label: 'User',
          ),
        ],
      ),
    );
