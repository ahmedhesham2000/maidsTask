import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/helper/cash_helper.dart';
import 'package:todoapp/controller/helper/dioHelper.dart';
import 'package:todoapp/model/todoModel.dart';
import 'package:todoapp/model/usertData.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  UserData? userData;
  List<TodoModel>? todoModel;
  int skip = 0;
  Future<void> getAllTodos() async {
    emit(GetAllTodosLoading());
    DioHelper.getDataAPI(
      // url: 'todos/user/${userData!.id}?limit=10&skip=$skip',
      url: 'todos/user/${userData!.id}',
    ).then((value) {
      print(value.data);
      Iterable list = value.data['todos'];

      todoModel = list.map((model) => TodoModel.fromJson(model)).toList();
      emit(GetAllTodosSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllTodosFailed(message: error.toString()));
    });
  }

  Future<void> addNewTodo({
    required String title,
  }) async {
    emit(AddNewTodoLoading());
    todoModel!.add(TodoModel(
      id: 0,
      title: title,
    ));
    DioHelper.postDataAPI(
      url: 'todos/add',
      data: {
        'title': title,
        'userId': userData!.id,
      },
    ).then((value) {
      print(value.data);
      emit(AddNewTodoSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(AddNewTodoFailed(message: error.response.data['message']));
    });
  }

  Future<void> updateTodo(
      {required int id, required bool completed, required int index}) async {
    emit(UpdateTodoLoading());
    if (id == 0) {
      todoModel![index].completed = completed;
      emit(UpdateTodoSuccess());
      return;
    }
    DioHelper.putDataAPI(
      url: 'todos/$id',
      data: {
        'completed': completed,
      },
    ).then((value) {
      print(value.data);
      todoModel!.firstWhere((element) => element.id == id).completed =
          completed;
      emit(UpdateTodoSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateTodoFailed(message: error.response.data['message']));
    });
  }

  Future<void> deleteTodo({
    required int id,
    required int index,
  }) async {
    emit(DeleteTodoLoading());
    if (id == 0) {
      todoModel!.removeAt(index);
      emit(DeleteTodoSuccess());
      return;
    }
    DioHelper.deleteDataAPI(
      url: 'todos/$id',
    ).then((value) {
      print(value.data);
      todoModel!.removeWhere((element) => element.id == id);
      emit(DeleteTodoSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteTodoFailed(message: error.toString()));
    });
  }

  void logout() {
    CacheHelper.clearAllData();
    emit(LogoutSuccess());
  }
}
