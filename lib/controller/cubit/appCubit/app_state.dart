part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class GetAllTodosLoading extends AppState {}

final class GetAllTodosSuccess extends AppState {}

final class GetAllTodosFailed extends AppState {
  final String message;

  GetAllTodosFailed({required this.message});
}

final class AddNewTodoLoading extends AppState {}

final class AddNewTodoSuccess extends AppState {}

final class AddNewTodoFailed extends AppState {
  final String message;

  AddNewTodoFailed({required this.message});
}

final class UpdateTodoLoading extends AppState {}

final class UpdateTodoSuccess extends AppState {}

final class UpdateTodoFailed extends AppState {
  final String message;

  UpdateTodoFailed({required this.message});
}

final class DeleteTodoLoading extends AppState {}

final class DeleteTodoSuccess extends AppState {}

final class DeleteTodoFailed extends AppState {
  final String message;

  DeleteTodoFailed({required this.message});
}

final class LogoutSuccess extends AppState {}
