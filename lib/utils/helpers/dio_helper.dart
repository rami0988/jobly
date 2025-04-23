import 'package:dio/dio.dart';
import 'package:jobly/utils/constants.dart';
class DioHelper
{
  static late Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: '${baseUrl}api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data,
    String lang = 'en',
    String? token,
  })async
  {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters:query,
      data: data,
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response?> deleteData({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };

    return dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response?> putData({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers={
      'content_type':'application/json',
      'lang':lang,
      'Authorization': 'Bearer $token',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }









}