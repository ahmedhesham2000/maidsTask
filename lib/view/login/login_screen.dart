import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/cubit/loginCubit/login_cubit.dart';
import 'package:todoapp/view/home/home_screen.dart';

import 'package:todoapp/view/login/widgets/login_container_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Stack(
          children: [
            Image.asset(
              'assets/images/login_background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            const Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Task Manager \nApp',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff4A4A4A),
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    HomeContaienerWidget(
                      key: ValueKey(2),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}
