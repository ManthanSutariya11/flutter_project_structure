import 'package:flutter/material.dart';
import 'package:project_structure/data/dio_api_service.dart';
import 'package:project_structure/model/post_model.dart';

class AppProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Post> posts = [];

  Future<void> updateIsLoading(bool value) async {
    await Future.delayed(const Duration(microseconds: 1));
    isLoading = value;
    notifyListeners();
  }

  void fetchPosts() async {
    updateIsLoading(true);
    List<Post> postList = await DioApiService.fetchPost();
    updateIsLoading(false);
    posts = postList;
    notifyListeners();
  }
}
