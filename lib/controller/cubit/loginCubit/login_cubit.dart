import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/controller/helper/cash_helper.dart';
import 'package:todoapp/controller/helper/dioHelper.dart';
import 'package:todoapp/model/usertData.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  UserData? userData;
  Future<void> login(String userName, String password) async {
    emit(LoginLoading());
    DioHelper.postDataAPI(
      url: 'auth/login',
      data: {'username': userName, 'password': password, 'expiresInMins': 60},
    ).then((value) {
      print(value.data);
      userData = UserData.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: userData!.token);
      emit(LoginSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(LoginFailed(message: error.toString()));
    });
  }

  Future<void> checkToken(String token) async {
    emit(CheckTokenLoading());
    DioHelper.postDataAPI(
      url: 'auth/refresh',
      token: token,
    ).then((value) {
      print(value.data);
      userData = UserData.fromJson(value.data);
      emit(CheckTokenSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CheckTokenFailed(message: error.toString()));
    });
  }
}
