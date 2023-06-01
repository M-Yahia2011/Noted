import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure("Long time to connect");

      case DioErrorType.sendTimeout:
        return ServerFailure("send timeout problem");
      case DioErrorType.receiveTimeout:
        return ServerFailure("receive Timeout");
      case DioErrorType.badCertificate:
        return ServerFailure("badCertificate");
      case DioErrorType.badResponse:
        ServerFailure.fromResponse(e.response!);
        return ServerFailure("Long time to connect");
      case DioErrorType.cancel:
        return ServerFailure("the server canceled the request");
      case DioErrorType.connectionError:
        return ServerFailure("Internet Connection has a problem");
      case DioErrorType.unknown:
        return ServerFailure("unknown error occured");
    }
  }
  factory ServerFailure.fromResponse(Response response) {
    switch (response.statusCode) {
      case 404:
        return ServerFailure("Your request was not found!");
      case 401:
        return ServerFailure("faild to authinticate");
      case 403:
        return ServerFailure("You don't have the right permission!");
      default:
        return ServerFailure("Unknow Error");
    }
  }
}
