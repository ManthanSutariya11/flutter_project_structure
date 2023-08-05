import 'package:flutter/material.dart';
import 'package:project_structure/constants/route_path.dart';
import 'package:project_structure/model/post_model.dart';
import 'package:project_structure/view/home_screen.dart';
import 'package:project_structure/view/post_detail.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePath.homeScreen:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return const HomeScreen();
      });
    case RoutePath.postDetail:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        Post postArg = settings.arguments as Post;
        return PostDetail(
          post: postArg,
        );
      });
    default:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return const Scaffold();
      });
  }
}
