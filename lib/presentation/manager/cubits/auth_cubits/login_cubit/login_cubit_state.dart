part of 'login_cubit_cubit.dart';

@immutable
abstract class LoginCubitState {}

class LoginCubitInitial extends LoginCubitState {}

class LoginLoading extends LoginCubitState {}

class LoginSuccess extends LoginCubitState {
  final UserEntity user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginCubitState {
  final String message;

  LoginFailure(this.message);
}
