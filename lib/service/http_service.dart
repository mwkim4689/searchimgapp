import 'package:dio/dio.dart';

class HttpService {

  static String IMG_SEARCH_URL = "https://dapi.kakao.com/v2/search/image";

  static Dio getDio() {

    String REST_API_KEY = "bc44da37a34a84e4e8e5ec5a7727429a";

    Map<String, dynamic> headers = {
      "Authorization": "KakaoAK $REST_API_KEY"
    };

    BaseOptions option = BaseOptions(
        headers: headers
    );

    Dio dio = Dio(option);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;

  }


  static Future<String> fetchImages({required String searchText}) async {

    Map<String, dynamic> queryParams = {"query" : searchText};


    Response response;
    response = await getDio().get(IMG_SEARCH_URL, queryParameters: queryParams);


    return response.data.toString();

  }



}