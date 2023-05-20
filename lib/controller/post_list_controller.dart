import 'package:api_test/data/api_server/post_api-service.dart';
import 'package:api_test/data/model/post_list_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/_html/_file_decoder_html.dart';

class PostListController extends GetxController {
  PostApiService _postApiService = Get.find();
  Rx<PostListState> postListState = PostListState().obs;
  @override
  void onInit() {
    super.onInit();
    getAllpost();
  }

  void getAllpost() {
    postListState.value = PostListLoading();
    _postApiService
        .getAllPosts()
        .then((postLists) => postListState.value = PostListSuccess(postLists))
        .catchError((e) {
      postListState.value = PostListError();
    });
  }
}

class PostListState {}

class PostListLoading extends PostListState {}

class PostListSuccess extends PostListState {
  final List<PostListModel> postLists;

  PostListSuccess(this.postLists);
}

class PostListError extends PostListState {}
