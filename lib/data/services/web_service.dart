import 'package:dio/dio.dart';
import 'package:noted/helpers/constants.dart';

class NotesWebService {
  List<dynamic> notes = [];

  Dio dio = Dio();
  // Dio(BaseOptions(
  //   baseUrl: Constants.baseUrl,
  //   receiveDataWhenStatusError: true,
  //   connectTimeout: const Duration(milliseconds: 20*1000),
  // ));
  Future<List> getAllNotes() async {
    try {
      Response response = await dio.get('${Constants.baseUrl}notes');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // add note

  // remove note

  // update note
}
