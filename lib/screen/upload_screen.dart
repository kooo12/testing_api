import 'dart:io';

import 'package:api_test/controller/upload_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as d;

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  UploadController _uploadController = Get.put(UploadController());
  GlobalKey<FormState> _key = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _title, _body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post'),
      ),
      body: Obx(() {
        UploadState uploadState = _uploadController.uploadState.value;
        if (uploadState is UploadLoading) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Uploading ... ${(_uploadController.percentage * 100).toInt()}'),
                Divider(),
                CircularProgressIndicator(
                    value: (_uploadController.percentage * 100))
              ],
            ),
          );
        } else if (uploadState is UploadError) {
          return const Center(
            child: Text('Something wrong'),
          );
        } else if (uploadState is UploadSuccess) {
          return Center(child: Text(uploadState.uploadRespond.result ?? ''));
        }
        return Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        "Enter Title",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                            wordSpacing: 10),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        onSaved: (title) {
                          _title = title;
                        },
                        validator: (title) {
                          if (title == null || title.isEmpty) {
                            return 'Please enter title';
                          }
                        },
                      ),
                      const Divider(),
                      const Text(
                        "Enter Body",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                            wordSpacing: 10),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        minLines: 2,
                        maxLines: 5,
                        onSaved: (body) {
                          _body = body;
                        },
                        validator: (body) {
                          if (body == null || body.isEmpty) {
                            return 'Please enter body';
                          }
                        },
                      ),
                      const Divider(),
                      IconButton(
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _image = File(image.path);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate,
                          size: 30,
                        ),
                      ),
                      const Center(
                          child: Text(
                        'Upload Photo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        height: 40,
                      ),
                      (_image == null)
                          ? const SizedBox()
                          : Image.file(
                              _image!,
                              height: 300,
                            ),
                      ElevatedButton.icon(
                          onPressed: () async {
                            d.MultipartFile? multipartFile;
                            d.FormData? formData;
                            if (_image != null) {
                              multipartFile = await d.MultipartFile.fromFile(
                                  _image!.path,
                                  filename: 'image.png');
                            }
                            _key.currentState!.save();
                            if (_key.currentState != null &&
                                _key.currentState!.validate()) {
                              if (multipartFile != null) {
                                formData = d.FormData.fromMap(
                                    {'photo': multipartFile});
                              }
                              _uploadController.Upload(
                                  title: _title ?? '',
                                  body: _body ?? '',
                                  photo: formData);
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Upload'))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
