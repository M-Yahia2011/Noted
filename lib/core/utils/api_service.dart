import 'package:dio/dio.dart';
import 'constants.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});
// TODO: token in the post request
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    Response response = await dio.get("${Constants.baseUrl}$endPoint");
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, required Map<String, dynamic> noteMap}) async {
    Response response =
        await dio.post("${Constants.baseUrl}$endPoint", data: {"data":noteMap});
    return response.data;
  }
}
