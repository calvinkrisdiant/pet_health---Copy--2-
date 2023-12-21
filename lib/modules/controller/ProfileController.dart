import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = "Catty".obs;
  var email = "catty@cat.com".obs;

  void updateProfile(String newName, String newEmail) {
    name(newName);
    email(newEmail);
  }
}
