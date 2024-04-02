import 'package:dio/dio.dart';
import 'package:searchimgapp/data/response/documents_response.dart';

class HttpService {
  static String IMG_SEARCH_URL = "https://dapi.kakao.com/v2/search/image";

  static Dio getDio() {
    String restApiKey = "bc44da37a34a84e4e8e5ec5a7727429a";

    Map<String, dynamic> headers = {"Authorization": "KakaoAK $restApiKey"};

    BaseOptions option = BaseOptions(
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
    );

    Dio dio = Dio(option);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  static Future<DocumentsResponse> fetchImages(
      {required String searchText, int? page, required int? size}) async {
    Map<String, dynamic> queryParams = {
      "query": searchText,
      "page": page,
      "size": size,
    };

    Response response =
        await getDio().get(IMG_SEARCH_URL, queryParameters: queryParams);

    return DocumentsResponse.fromJson(response.data);
  }
}
