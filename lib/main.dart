import 'package:cart_app_viva/views/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.light(useMaterial3: true),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
      ],
    ),
  );
}