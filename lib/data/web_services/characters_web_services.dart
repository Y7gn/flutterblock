import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio dio;
  Duration timeoutDuration = Duration(seconds: 20);
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: timeoutDuration,
      receiveTimeout: timeoutDuration,
    );

    dio = Dio(options);
  }
  var headers = {'X-Api-Key': 'dkIJcFtlI3RhO1l/wBrX4w==SF92NWIOT9yitpZu'};
  Future<List<dynamic>> getAllCharacters() async {
    final dataresponse;
    try {
      Response response = await dio.get('/');
      print(response.data.toString());
      dataresponse = response.data['results'];
      print(dataresponse);
      return dataresponse;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharactersQuotes() async {
    final dataresponse;
    try {
      dio.options.headers = headers;
      Response response = await dio.get('https://api.api-ninjas.com/v1/quotes');
      print(response.data);
      // dataresponse = response.data['results'];
      // print(dataresponse);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
