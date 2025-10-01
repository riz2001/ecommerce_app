import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/login_page.dart';
import 'home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/home", page: () =>  HomePage()),
      ],
    );
  }
}
