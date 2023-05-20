import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _darkTheme = false;
  bool _language = false;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    _darkTheme = (brightness == Brightness.dark);

    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Text('Dark Theme'),
              trailing: Switch(
                  value: _darkTheme,
                  onChanged: (value) {
                    if (value) {
                      Get.changeTheme(ThemeData.dark());
                    } else {
                      Get.changeTheme(ThemeData.light());
                    }
                    setState(() {
                      _darkTheme = value;
                    });
                  }),
            ),
          ),
          Card(
            child: ListTile(
              leading: Text('Myanmar Language'),
              trailing: Switch(
                  value: _language,
                  onChanged: (val) {
                    if (val) {
                      Get.updateLocale(Locale('en', 'MM'));
                    } else {
                      Get.updateLocale(Locale('en', 'US'));
                    }
                    setState(() {
                      _language = val;
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }
}
