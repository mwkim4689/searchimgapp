import 'package:dio/dio.dart';

class HttpService {


  static Dio getDio() {

    Map<String, dynamic> headers = {
      "Authorization": ""
    };

    BaseOptions option = BaseOptions(
        headers: headers
    );

    Dio dio = Dio(option);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;

  }


  static Future<String> fetchImages() async {


    Response response;
    response = await getDio().get('url',);


    return response.data.toString();

  }



}