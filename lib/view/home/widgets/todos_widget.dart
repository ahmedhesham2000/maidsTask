import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/controller/cubit/appCubit/app_cubit.dart';

class TodosWidget extends StatelessWidget {
  const TodosWidget({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cubit.todoModel!.length,
      itemBuilder: (context, index) {
        final item = cubit.todoModel![index];
        return Dismissible(
          key: Key(item.id!.toString()),
          confirmDismiss: (direction) => AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.bottomSlide,
            title: 'Are you sure You want to delete this todo?',
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              cubit.deleteTodo(
                id: item.id!,
                index: index,
              );
            },
            btnOkText: 'Delete',
          ).show().then((value) => null),
          background: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
          child: ListTile(
            title: Text('${item.title}',
                style: TextStyle(
                    decoration: item.completed!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            trailing: Checkbox(
                value: item.completed,
                onChanged: (v) {
                  cubit.updateTodo(
                      id: item.id!, completed: !item.completed!, index: index);
                }),
          ),
        );
      },
    );
  }
}
