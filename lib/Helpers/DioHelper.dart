import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        headers: {
          "lang":"en",
          "Content-Type": "application/json",
        },
        receiveDataWhenStatusError: true));
  }
static Future<Response> putData({required String path,required Map<String ,dynamic> data}){
return dio.put(path,data: data);
}
  static Future<Response> postData({
    required String path,
    required dynamic data,
  }) async{
    return await dio.post(path, data: data);
  }

  Future<Response> get(
      {required String url,   Map<String, dynamic>? query}) {
    return dio.get(url, queryParameters: query);
  }
}
