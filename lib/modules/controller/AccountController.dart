import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_health/modules/controller/ClientController.dart';
import 'package:pet_health/modules/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends ClientController {
  Account? account;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    account = Account(client);
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      // Periksa status login menggunakan metode getUser
      //user = await account.get();
      //isLoggedIn.value = user != null;
    } catch (error) {
      print("Error checking login status: $error");
      isLoggedIn.value = false;
    }
  }

  

  Future<void> createAccount(Map<String, dynamic> map) async {
    try {
      final result = await account!.create(
        userId: map['userId'],
        email: map['email'],
        password: map['password'],
        name: map['name'],
      );
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(LoginPage());
      print("AccountController:: createAccount $result");
    } catch (error) {
      _showErrorDialog("Error Account", "$error");
      Get.snackbar('ERROR', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createEmailSession(Map<String, dynamic> map) async {
    try {
      final result = await account!.createEmailSession(
        email: map['email'],
        password: map['password'],
      );

      Get.snackbar('Success', 'Login Successful',
          backgroundColor: Colors.green);
      isLoggedIn.value = true;
      Get.offAllNamed('/homescreen');
      print("AccountController:: createEmailSession $result");
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
      _showErrorDialog("Error Account", "$error");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _prefs.remove('user_token');
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  void _showErrorDialog(String title, String content) {
    Get.defaultDialog(
      title: title,
      titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
      titleStyle: Get.context?.theme.textTheme.titleLarge,
      content: Text(
        content,
        style: Get.context?.theme.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
    );
  }
}
