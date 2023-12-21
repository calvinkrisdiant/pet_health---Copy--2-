import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_health/modules/controller/ProfileController.dart';
import 'package:pet_health/modules/controller/auth_controller.dart';
import 'package:pet_health/modules/view/EditProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final AuthController _authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Anda'),
        actions: [
          IconButton(
              onPressed: () {
                _authController.logout();
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('images/assets/cats.jpeg'),
            ),
            SizedBox(height: 20),
            Obx(() => Text(
                  profileController.name.value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(height: 10),
            Obx(() => Text(
                  profileController.email.value,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final Map<String, String>? updatedData = await Get.to(
                  EditProfileScreen(),
                );

                if (updatedData != null) {
                  profileController.updateProfile(
                    updatedData['name'] ?? profileController.name.value,
                    updatedData['email'] ?? profileController.email.value,
                  );
                }
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
