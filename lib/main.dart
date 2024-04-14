import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/const.dart';
import 'package:todoapp/controller/cubit/appCubit/app_cubit.dart';
import 'package:todoapp/controller/cubit/loginCubit/login_cubit.dart';
import 'package:todoapp/controller/helper/bloc_observe.dart';
import 'package:todoapp/controller/helper/cash_helper.dart';
import 'package:todoapp/controller/helper/dioHelper.dart';
import 'package:todoapp/view/spalsh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LoginCubit()
                ..checkToken(CacheHelper.getData(key: 'token') ?? '')),
          BlocProvider(create: (context) => AppCubit()),
        ],
        child: MaterialApp(
          title: 'Task Manager',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ));
  }
}
