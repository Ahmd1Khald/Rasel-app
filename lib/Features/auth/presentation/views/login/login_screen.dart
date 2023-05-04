import 'package:chatapp/Features/auth/presentation/views/login/widgets/login_body.dart';
import 'package:chatapp/bloc/cubit.dart';
import 'package:chatapp/bloc/state.dart';
import 'package:chatapp/core/utils/constants/variables.dart';
import 'package:chatapp/screens/otp.dart';
import 'package:chatapp/Features/auth/presentation/views/register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/functions.dart';
import '../../../../../core/widgets/components.dart';
import '../../manger/login_cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const LoginBody();
  }
}
