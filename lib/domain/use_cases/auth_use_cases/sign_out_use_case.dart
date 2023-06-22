import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import '/data/repos/user_repo_impl.dart';
import '/domain/use_cases/use_case.dart';

class SignOutUsecase extends UseCase<void, Map<String, dynamic>?> {
  final UserRepoImpl _userRepoImpl;

  SignOutUsecase(this._userRepoImpl);
  @override
  Future<Either<Failure, void>> execute(
      [Map<String, dynamic>? parameter]) async {
    return await _userRepoImpl.singOut(parameter!);
  }
}
