part of 'register_cubit_cubit.dart';

@immutable
abstract class RegisterCubitState {}

class RegisterCubitInitial extends RegisterCubitState {}
class RegisterLoading extends RegisterCubitState {}

class RegisterSuccess extends RegisterCubitState {
  final UserEntity user;

  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterCubitState {
  final String message;

  RegisterFailure(this.message);
}
