import 'package:api_test/screen/home.dart';
import 'package:api_test/screen/setting_screen.dart';
import 'package:api_test/screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;
  Widget _body = Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_card), label: 'upload'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'setting'.tr),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              _body = Home();
            } else if (index == 1) {
              _body = UploadScreen();
            } else if (index == 2) {
              _body = SettingScreen();
            }
          });
        },
      ),
    );
  }
}
