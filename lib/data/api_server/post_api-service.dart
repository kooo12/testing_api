import 'package:api_test/data/model/blog_post.dart';
import 'package:api_test/data/model/post_list_model.dart';
import 'package:api_test/data/model/upload_respond.dart';
import 'package:dio/dio.dart';

class PostApiService {
  static const baseurl = 'http://44.207.161.4:5000';
  Dio _dio = Dio();
  Future<List<PostListModel>> getAllPosts() async {
    var result = await _dio.get('$baseurl/posts');
    List postList = result.data as List;
    return postList.map((post) {
      return PostListModel.fromjson(post);
    }).toList();
  }

  Future<List<BlogPost>> getPost(int id) async {
    var result = await _dio.get('$baseurl/post?id=$id');
    List postList = result.data as List;
    return postList.map((post) {
      return BlogPost.fromJson(post);
    }).toList();
  }

  Future<UploadRespond> uploadPost(
      {required String title,
      required String body,
      required FormData? photo,
      required Function(int, int) uploadProgress}) async {
    var result = await _dio.post('$baseurl/post?title=$title&body=$body',
        data: photo, onSendProgress: uploadProgress);
    UploadRespond uploadRespond = UploadRespond.fromJson(result.data);
    return uploadRespond;
  }
}
