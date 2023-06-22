// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '/domain/use_cases/auth_use_cases/register_use_case.dart';

import '../../../../../domain/entities/user_entity.dart';

part 'register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit(this._registerUsecase) : super(RegisterCubitInitial());
  final RegisterUsecase _registerUsecase;
  Future<void> register({required Map<String, dynamic> userData}) async {
    emit(RegisterLoading());

    var result = await _registerUsecase.execute(userData);
    result.fold((failure) => emit(RegisterFailure(failure.message)),
        (user) => emit(RegisterSuccess(user)));
  }
}
