import 'package:RASEL/Features/home/presentation/manger/home_cubit/home_state.dart';
import 'package:RASEL/Features/home/presentation/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../Core/utils/constants/functions.dart';
import '../../../../../../Core/widgets/components.dart';
import '../../../../data/models/user_model.dart';
import '../../../manger/home_cubit/home_cubit.dart';
import '../../drawer/mydrawer.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    //required this.result,
  }) : super(key: key);

  //final UserModel result;

  @override
  Widget build(BuildContext context) {
    //print('++++++++++++++++++++++++\n$result');
    UserModel? result;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        //Loading
        if (state is HomeLoadingFetchUserData) {
          AppFunctions.loadingPage(context: context);
        }
        //Success
        else if (state is HomeSuccessFetchUserData) {
          result = state.userData;
          //myToast(state: 'Fetched success!', toastState: ToastState.success);
          print('--------------');
          print(result);
          print('--------------');
          //Navigator.pop(context);
        }
        //Error
        else if (state is HomeErrorFetchUserData) {
          myToast(state: state.errorMsg, toastState: ToastState.error);
          print(state.errorMsg);
          //Navigator.pop(context);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        print('result => $result');
        return Scaffold(
          backgroundColor: Colors.grey[350],
          appBar: AppBar(
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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.bottomChanged(index: index);
              print(cubit.currentIndex);
            },
            //type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    FontAwesomeIcons.house,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    FontAwesomeIcons.user,
                  ),
                ),
                label: 'User',
              ),
            ],
          ),
          drawer: MyDrawer(
            userdata: result,
          ),
          body: cubit.widgets[cubit.currentIndex],
        );
      },
    );
  }
}
