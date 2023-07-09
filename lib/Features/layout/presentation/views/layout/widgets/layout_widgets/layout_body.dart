import 'package:RASEL/Core/utils/constants/colors.dart';
import 'package:RASEL/Core/utils/constants/styles.dart';
import 'package:RASEL/Features/layout/presentation/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../Core/utils/constants/functions.dart';
import '../../../../../../../Core/widgets/components.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../data/repos/repo_implement.dart';
import '../../../../manger/layout_cubit/layout_cubit.dart';
import '../../../../manger/layout_cubit/layout_state.dart';
import '../../../drawer/mydrawer.dart';
import 'add_post.dart';

class LayoutBody extends StatelessWidget {
  LayoutBody({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;
  UserModel? result;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            LayoutCubit(LayoutRepoImplement())..fetchUserData(uid: uid),
        child: BlocConsumer<LayoutCubit, LayoutState>(
          listener: (context, state) {
            if (state is LayoutAddPostsState) {
              AppFunctions.push(
                context: context,
                screen: const AppPostScreen(),
              );
            }
            //Loading
            if (state is LayoutLoadingFetchUserData) {
              AppFunctions.loadingPage(context: context);
            }
            //Success
            else if (state is LayoutSuccessFetchUserData) {
              result = state.userData;
            }
            //Error
            else if (state is LayoutErrorFetchUserData) {
              myToast(
                state: state.errorMsg,
                toastState: ToastState.error,
              );
            }
          },
          builder: (context, state) {
            print('result => $result');
            //LayoutCubit cubit = LayoutCubit.get(context);
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                backgroundColor: AppColors.sidesColor,
                title: SpinKitSpinningCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: const BoxDecoration(
                          //color: index.isEven ? Colors.white : Colors.white.withOpacity(0.5),
                          /*image: DecorationImage(
                          image: AssetImage(AppAssetsImages.logoImage),
                        ),*/
                          ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Rasel',
                          style: AppStyles.title3,
                        ),
                      ),
                    );
                  },
                  duration: const Duration(milliseconds: 9500),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      ///todo notification screen
                    },
                    icon: const Icon(
                      Icons.notifications,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      AppFunctions.push(
                        context: context,
                        screen: const ChatScreen(),
                      );
                    },
                    icon: const Icon(
                      Icons.chat_bubble,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: myBottomNavBar(context: context),
              drawer: MyDrawer(
                userdata: result,
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
