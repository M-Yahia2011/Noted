import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Long time to connect");

      case DioExceptionType.sendTimeout:
        return ServerFailure("send timeout problem");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("receive Timeout");
      case DioExceptionType.badCertificate:
        return ServerFailure("badCertificate");
      case DioExceptionType.badResponse:
        ServerFailure.fromResponse(e.response!);
        return ServerFailure("Long time to connect");
      case DioExceptionType.cancel:
        return ServerFailure("the server canceled the request");
      case DioExceptionType.connectionError:
        return ServerFailure("Internet Connection has a problem");
      case DioExceptionType.unknown:
        return ServerFailure("unknown error occured");
    }
  }
  factory ServerFailure.fromResponse(Response response) {
    return ServerFailure(response.statusMessage!);
    // switch (response.statusCode) {
    // case 404:
    //   return ServerFailure("Your request was not found!");
    // case 401:
    //   return ServerFailure("faild to authinticate");
    // case 403:
    //   return ServerFailure("You don't have the right permission!");
    //   case 405:

    // default:
    // return ServerFailure("Unknow Error");
    // }
  }
}
