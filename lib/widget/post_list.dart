import 'package:api_test/data/model/post_list_model.dart';
import 'package:api_test/screen/blog_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class PostListWidget extends StatelessWidget {
  final List<PostListModel> posts;
  PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(BlogPostScreen(
                  id: posts[index].id ?? 0, title: posts[index].title ?? ''));
            },
            child: Card(
                child: Center(
                    child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(posts[index].title ?? ''),
            ))),
          );
        });
  }
}
