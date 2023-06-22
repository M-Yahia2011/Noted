import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import '/domain/entities/user_entity.dart';

abstract class UserRepoAbstract {
  Future<Either<Failure, UserEntity>> signIn(Map<String, dynamic> userMap);
   Future<Either<Failure, UserEntity>> register(Map<String, dynamic> userMap);
   Future<Either<Failure, void>> singOut(Map<String, dynamic> userMap);
}
