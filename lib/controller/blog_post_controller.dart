import 'package:api_test/data/api_server/post_api-service.dart';
import 'package:api_test/data/model/blog_post.dart';
import 'package:get/get.dart';

class BlogPostController extends GetxController {
  final PostApiService _postApiService = Get.find();
  Rx<BlogPostState> blogPostState = BlogPostState().obs;
  void getPost(int id) {
    blogPostState.value = BlogPostLoading();
    _postApiService.getPost(id).then((posts) {
      if (posts.isNotEmpty) {
        blogPostState.value = BlogPostSuccess(posts[0]);
      }
    }).catchError((e) {
      blogPostState.value = BlogPostError();
    });
  }
}

class BlogPostState {}

class BlogPostLoading extends BlogPostState {}

class BlogPostSuccess extends BlogPostState {
  final BlogPost post;

  BlogPostSuccess(this.post);
}

class BlogPostError extends BlogPostState {}
