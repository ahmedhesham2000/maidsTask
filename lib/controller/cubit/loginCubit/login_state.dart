part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {

}

final class LoginFailed extends LoginState {
  final String message;

  LoginFailed({required this.message});
}

final class CheckTokenLoading extends LoginState {}

final class CheckTokenSuccess extends LoginState {}

final class CheckTokenFailed extends LoginState {
  final String message;

  CheckTokenFailed({required this.message});
}
