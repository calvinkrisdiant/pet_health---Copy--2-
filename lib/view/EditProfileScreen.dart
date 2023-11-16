import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pet_health/controller/ProfileController.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = Get.find<ProfileController>().name.value;
    emailController.text = Get.find<ProfileController>().email.value;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      // Tambahkan logika untuk menyimpan gambar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Pilih foto profil"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _pickImage(ImageSource.gallery);
                          },
                          child: Text('Dari Galeri'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _pickImage(ImageSource.camera);
                          },
                          child: Text('Dari Kamera'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                child: Icon(Icons.camera_alt, size: 60),
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Anda'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email Anda'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back(result: {
                  'name': nameController.text,
                  'email': emailController.text,
                });
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}
