import 'dart:convert';

import 'package:dio/dio.dart';
import 'constants.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});
// TODO: token in the post request

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    Response response = await dio.get("${Constants.notesBaseUrl}$endPoint");
    // firebase return null if there are no notes in the collection
    if (response.data == null) {
      return {};
    }
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, required Map<String, dynamic> noteMap}) async {
    Response response = await dio.post("${Constants.notesBaseUrl}$endPoint",
        data: jsonEncode(noteMap));
    return response.data;
  }

  Future<void> delete(
      {required String endPoint, required String noteId}) async {
    Response response =
        await dio.delete("${Constants.notesBaseUrl}$endPoint/$noteId.json");
    return response.data;
  }
}
