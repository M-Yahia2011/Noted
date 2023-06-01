import 'package:dartz/dartz.dart';
import 'package:noted/core/errors/failure.dart';

abstract class UseCase<ReturnType, FunctionParameter> {
  Future<Either<Failure, ReturnType>> execute([FunctionParameter parameter]);
}

class NoParameter {}
