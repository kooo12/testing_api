import 'package:api_test/data/api_server/post_api-service.dart';
import 'package:api_test/screen/home.dart';
import 'package:api_test/utils/local.dart';
import 'package:api_test/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(PostApiService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: RestApiLanguage(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: BottomNavigator(),
    );
  }
}
