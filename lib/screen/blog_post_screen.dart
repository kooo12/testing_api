import 'package:api_test/controller/blog_post_controller.dart';
import 'package:api_test/data/api_server/post_api-service.dart';
import 'package:api_test/data/model/blog_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BlogPostScreen extends StatefulWidget {
  final int id;
  final String title;
  BlogPostScreen({super.key, required this.id, required this.title});

  @override
  State<BlogPostScreen> createState() => _BlogPostScreenState();
}

class _BlogPostScreenState extends State<BlogPostScreen> {
  BlogPostController blogPostController = Get.put(BlogPostController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blogPostController.getPost(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Obx(() {
        BlogPostState blogPostState = blogPostController.blogPostState.value;

        if (blogPostState is BlogPostSuccess) {
          BlogPost posts = blogPostState.post;
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(posts.title ?? ''),
                )),
                Divider(),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(posts.body ?? ''),
                )),
                Divider(),
                (posts.photo == null)
                    ? SizedBox()
                    : Image.network('${PostApiService.baseurl}/${posts.photo}')
              ],
            ),
          );
        }
        if (blogPostState is BlogPostError) {
          return Center(
            child: Text('Error'),
          );
        }
        if (blogPostState is BlogPostLoading) {
          return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 250,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ));
        }
        return SizedBox();
      }),
    );
  }
}
