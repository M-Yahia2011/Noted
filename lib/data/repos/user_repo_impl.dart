import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:noted/core/errors/failure.dart';
import 'package:noted/data/data_sources/firebase_auth.dart';
import 'package:noted/domain/entities/user_entity.dart';
import 'package:noted/domain/repos/user_repo_abstract.dart';

class UserRepoImpl extends UserRepoAbstract {
  final AuthService _authService;

  UserRepoImpl(this._authService);
  @override
  Future<Either<Failure, UserEntity>> register(
      Map<String, dynamic> userMap) async {
    try {
      var result =
          await _authService.register(userMap["email"], userMap["password"]);

      return right(UserEntity(
          id: result.user!.uid,
          image: result.user!.photoURL!,
          email: result.user!.email!));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
      Map<String, dynamic> userMap) async {
    try {
      var result =
          await _authService.signIn(userMap["email"], userMap["password"]);

      return right(UserEntity(
          id: result.user!.uid,
          image: result.user!.photoURL!,
          email: result.user!.email!));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> singOut(Map<String, dynamic> userMap) async {
    try {
      await _authService.signOut(userMap["email"], userMap["password"]);
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
