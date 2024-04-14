import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoapp/controller/const.dart';
import 'package:todoapp/controller/cubit/loginCubit/login_cubit.dart';
import 'package:todoapp/view/widgets/textFormField_widget.dart';

class HomeContaienerWidget extends StatefulWidget {
  const HomeContaienerWidget({super.key});

  @override
  State<HomeContaienerWidget> createState() => _HomeContaienerWidgetState();
}

class _HomeContaienerWidgetState extends State<HomeContaienerWidget> {
  bool isPasswordVisible = false;

  TextEditingController userNameController =
      TextEditingController(text: 'kminchelle');
  TextEditingController passwordController =
      TextEditingController(text: '0lelplR');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Form(
              key: formKey,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text('LOG IN',
                      style: TextStyle(
                        color: Color(0xff4A4A4A),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
                  child: SizedBox(
                    height: height * 0.08,
                    child: TextFormfieldWidget(
                      controller: userNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your user name';
                        }
                      },
                      hintText: 'User Name',
                      isPassword: false,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: height * 0.08,
                    child: TextFormfieldWidget(
                      controller: passwordController,
                      hintText: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                      },
                      isPassword: true,
                      obscureText: !isPasswordVisible,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30, bottom: 50),
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.login(
                              userNameController.text, passwordController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff7BB3FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(388, 46)),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
