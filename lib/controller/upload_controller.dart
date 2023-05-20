import 'package:api_test/controller/post_list_controller.dart';
import 'package:api_test/data/api_server/post_api-service.dart';
import 'package:api_test/data/model/upload_respond.dart';
import 'package:api_test/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

class UploadController extends GetxController {
  PostApiService _postApiService = Get.find();
  PostListController postListController = Get.find();
  RxDouble percentage = 0.0.obs;
  Rx<UploadState> uploadState = UploadState().obs;
  void Upload(
      {required String title,
      required String body,
      required d.FormData? photo}) {
    uploadState.value = UploadLoading();
    _postApiService
        .uploadPost(
            title: title,
            body: body,
            photo: photo,
            uploadProgress: (sent, data) {
              percentage.value = sent / data;
            })
        .then((uploadRespond) {
      uploadState.value = UploadSuccess(uploadRespond);
      Future.delayed(Duration(seconds: 1)).then((value) {
        Get.off(BottomNavigator());

        postListController.getAllpost();
        uploadState.value = UploadState();
      });
    }).catchError((e) {
      uploadState.value = UploadError();
    });
  }
}

class UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  final UploadRespond uploadRespond;

  UploadSuccess(this.uploadRespond);
}

class UploadError extends UploadState {}
