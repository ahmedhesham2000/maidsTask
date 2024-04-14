import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/cubit/appCubit/app_cubit.dart';
import 'package:todoapp/controller/cubit/loginCubit/login_cubit.dart';
import 'package:todoapp/controller/helper/navigation.dart';
import 'package:todoapp/controller/helper/show_sanckbar_method.dart';
import 'package:todoapp/view/home/widgets/todos_widget.dart';
import 'package:todoapp/view/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AppCubit.get(context).userData = LoginCubit.get(context).userData;
    AppCubit.get(context).getAllTodos();
    super.initState();
  }

  TextEditingController todoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushReplacement(
              context,
              buildPageRoute(const LoginScreen(), PageRouteAnimation.Fade,
                  const Duration(milliseconds: 500)));
        }
        if (state is AddNewTodoSuccess) {
          showSnackbar(context, 'Todo Added Successfully');
          todoController.clear();
          Navigator.pop(context);
        }

        if (state is UpdateTodoSuccess) {
          showSnackbar(context, 'Todo Updated Successfully');
        }
        if (state is DeleteTodoSuccess) {
          showSnackbar(context, 'Todo Deleted Successfully');
          Navigator.pop(context);
        }

        if (state is GetAllTodosFailed) {
          showSnackbar(context, state.message);
        }

        if (state is AddNewTodoFailed) {
          showSnackbar(context, state.message);
        }

        if (state is UpdateTodoFailed) {
          showSnackbar(context, state.message);
        }

        if (state is DeleteTodoFailed) {
          showSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Wlecome ${cubit.userData!.userName!}',
                style: const TextStyle(fontSize: 20)),
            backgroundColor: Colors.deepPurple.withOpacity(0.5),
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: cubit.userData!.userImg!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )),
            actions: [
              IconButton(
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.bottomSlide,
                    title: 'Are you sure you want to logout?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      cubit.logout();
                    },
                    btnOkText: 'Logout',
                  ).show();
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.infoReverse,
                animType: AnimType.rightSlide,
                title: 'Add New Todo',
                desc: 'Please enter your todo title',
                btnOk: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.addNewTodo(
                        title: todoController.text,
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: todoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your todo title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Todo Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ).show();
            },
            child: const Icon(Icons.add),
          ),
          body: state is GetAllTodosLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.todoModel!.isEmpty
                  ? const Center(
                      child: Text('No Todos Yet'),
                    )
                  : TodosWidget(cubit: cubit),
        );
      },
    );
  }
}
