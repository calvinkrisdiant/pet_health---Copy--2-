import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_health/controller/AccountController.dart';

import 'package:pet_health/screens/home_screen.dart';
import 'package:pet_health/screens/splash_screen.dart';
import 'package:pet_health/view/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

void navigateToHomeScreen(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ),
  );
}

class _LoginPageState extends State<LoginPage> {
  final AccountController accountController = Get.put(AccountController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SplashScreen(),
              ),
            );
          },
          icon: Icon(
            FeatherIcons.arrowLeft,
            color: Color(0xFF818AF9),
          ),
        ),
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            Obx(() {
              return ElevatedButton(
                onPressed: accountController.isLoading.value
                    ? null
                    : () async {
                        Map<String, dynamic> map = {
                          'email': _emailController.text,
                          'password': _passwordController.text,
                        };
                        await accountController.createEmailSession(map);
                      },
                child: accountController.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('Login'),
              );
            }),
            GestureDetector(
              child: Text('Dont Have Account? '),
              onTap: () {
                Navigator.pop(context);
                MaterialPageRoute(
                  builder: (context) => SignUpView(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
