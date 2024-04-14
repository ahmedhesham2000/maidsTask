import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/cubit/loginCubit/login_cubit.dart';
import 'package:todoapp/controller/helper/navigation.dart';
import 'package:todoapp/view/home/home_screen.dart';
import 'package:todoapp/view/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is CheckTokenFailed) {
          Navigator.pushAndRemoveUntil(
              context,
              buildPageRoute(const LoginScreen(), PageRouteAnimation.Fade,
                  const Duration(milliseconds: 500)),
              (route) => false);
        }
        if (state is CheckTokenSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              buildPageRoute(const HomeScreen(), PageRouteAnimation.Fade,
                  const Duration(milliseconds: 500)),
              (route) => false);
        }
      },
      child: Scaffold(
        body: Center(
          child: FadeTransition(
            opacity: _animation as Animation<double>,
            child: Image.asset('assets/logo/logo.png'),
          ),
        ),
      ),
    );
  }
}
