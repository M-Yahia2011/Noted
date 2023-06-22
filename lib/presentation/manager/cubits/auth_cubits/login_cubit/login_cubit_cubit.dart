// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:noted/domain/use_cases/auth_use_cases/sign_in_use_case.dart';

import '../../../../../domain/entities/user_entity.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit(this._signInUsecase) : super(LoginCubitInitial());

  final SignInUsecase _signInUsecase;
  Future<void> singIn({required Map<String, dynamic> userData}) async {
    emit(LoginLoading());

    var result = await _signInUsecase.execute(userData);
    result.fold((failure) => emit(LoginFailure(failure.message)),
        (user) => emit(LoginSuccess(user)));
  }
}
