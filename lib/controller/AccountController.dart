import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pet_health/controller/ClientController.dart';

class AccountController extends ClientController {
  late Account account;

  @override
  void onInit() {
    super.onInit();
    // appwrite
    account = Account(client);
  }

  Future<void> createAccount(Map<String, dynamic> map) async {
    try {
      final result = await account.create(
        userId: map['userID'],
        email: map['email'],
        password: map['password'],
        name: map['name'],
      );
      print("AccountController:: createAccount $result");
    } catch (error) {
      _showErrorDialog("Error Account", "$error");
    }
  }

  Future<void> createEmailSession(String email, String password) async {
    try {
      final result = await account.createSession(
        email: email,
        password: password,
      );
      print("AccountController:: createEmailSession $result");
    } catch (error) {
      _showErrorDialog("Error Account", "$error");
    }
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
