import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:project_structure/constants/app_config.dart';
import 'package:project_structure/model/post_model.dart';

class DioApiService {
  DioApiService._();
  final DioApiService _singleton = DioApiService._();
  DioApiService get instance => _singleton;

  static const String _uri = AppConfig.baseUrl;
  static final BaseOptions _options = BaseOptions(
    baseUrl: _uri,
    responseType: ResponseType.plain,
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 50),
  );
  static final Dio dio = Dio(_options);

  static Future<List<Post>> fetchPost() async {
    try {
      final response = await dio.get('/posts');
      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> jsonResponse = jsonDecode(response.data);
        List<Post> posts =
            jsonResponse.map<Post>((e) => Post.fromJson(e)).toList();
        return posts;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
