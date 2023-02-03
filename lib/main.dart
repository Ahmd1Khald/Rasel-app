import 'package:bloc/bloc.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/splash_screen.dart';
import 'package:chatapp/shared/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_obsever.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';
import 'firebase_options.dart';
import 'local/cachehelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  bool? inChat = CacheHelper.getDate(key: 'chatPage');
  //print(inChat);
  //inChat = false;

  if(inChat == true){
    widget = const ChatScreen();
  }else{
    widget = const LoginScreen();
  }

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
