import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_health/controller/ProfileController.dart';
import 'package:pet_health/view/EditProfileScreen.dart';
import 'package:pet_health/screens/splash_screen.dart';

void main() {
  Get.put(ProfileController()); // Inisialisasi ProfileController

  runApp(
    GetMaterialApp(
      title: 'Pet Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/edit_profile', page: () => EditProfileScreen()),
      ],
    ),
  );
}
