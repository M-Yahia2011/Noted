import 'dart:convert';
import 'package:dio/dio.dart';
import '../../data/data_sources/firebase_auth.dart';
import 'constants.dart';

class ApiService {
  Dio dio;
  ApiService({required this.dio});
  String? token;
  // var user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    token = await AuthService.getToken();

    Response response = await dio.get(
      "${Constants.notesBaseUrl}$endPoint",
      // options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    // firebase return null if there are no notes in the collection
    if (response.data == null) {
      return {};
    }
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, required Map<String, dynamic> noteMap}) async {
    Response response = await dio.post(
      "${Constants.notesBaseUrl}$endPoint",
      data: jsonEncode(noteMap),
      // options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<void> delete(
      {required String endPoint, required String noteId}) async {
    Response response = await dio.delete(
        "${Constants.notesBaseUrl}$endPoint/$noteId.json",
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data;
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint,
      required String noteId,
      required Map<String, dynamic> noteMap}) async {
    Response response = await dio.put(
        "${Constants.notesBaseUrl}$endPoint/$noteId.json",
        data: jsonEncode(noteMap),
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data;
  }
}
