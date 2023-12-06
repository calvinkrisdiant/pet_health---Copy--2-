import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_health/controller/DatabaseController.dart';
import 'package:pet_health/controller/auth_controller.dart';
import 'package:pet_health/controller/notification_handler.dart';
import 'package:pet_health/firebase_options.dart';
import 'package:pet_health/screens/DataModel.dart';
import 'package:pet_health/screens/home_screen.dart';
import 'package:pet_health/view/EditProfileScreen.dart';
import 'package:pet_health/screens/splash_screen.dart';
import 'package:pet_health/view/login_page.dart';
import 'package:pet_health/view/register_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingHandler().initPushNotification();
  await FirebaseMessagingHandler().initLocalNotification();
   Get.put(DatabaseController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: _authController.isLoggedIn.value ? '/homescreen' : '/login',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/edit_profile', page: () => EditProfileScreen()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => SignUpView()),
        GetPage(name: '/homescreen', page: () => HomeScreen()),

      ],
    );
  }
}
