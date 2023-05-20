import 'package:api_test/controller/post_list_controller.dart';
import 'package:api_test/data/api_server/post_api-service.dart';
import 'package:api_test/data/model/post_list_model.dart';
import 'package:api_test/widget/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final PostListController _postListController = Get.put(PostListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts API'),
        ),
        body: Obx(() {
          PostListState state = _postListController.postListState.value;
          if (state is PostListLoading) {
            return ListView(
              children: [
                for (int i = 0; i < 15; i++)
                  Shimmer.fromColors(
                      child: Container(
                        height: 30,
                        margin: const EdgeInsets.all(8.0),
                        color: Colors.grey,
                      ),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white)
              ],
            );
          } else if (state is PostListSuccess) {
            List<PostListModel> postList = state.postLists;
            return PostListWidget(posts: postList);
          } else if (state is PostListError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const Center();
        }));
  }
}
