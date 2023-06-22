import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import '/data/repos/user_repo_impl.dart';
import '/domain/entities/user_entity.dart';
import '/domain/use_cases/use_case.dart';

class SignInUsecase extends UseCase<UserEntity, Map<String, dynamic>?> {
  final UserRepoImpl _userRepoImpl;

  SignInUsecase(this._userRepoImpl);
  @override
  Future<Either<Failure, UserEntity>> execute(
      [Map<String, dynamic>? parameter]) async {
    return await _userRepoImpl.signIn(parameter!);
  }
}
