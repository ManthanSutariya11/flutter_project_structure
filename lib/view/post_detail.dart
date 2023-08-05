import 'package:flutter/material.dart';
import 'package:project_structure/model/post_model.dart';
import 'package:project_structure/utils/utils.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getString('post_detail')),
        backgroundColor: Colors.blue,
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(Utils.getString('back')),
            ),
          ],
        ),
      ),
    );
  }
}
