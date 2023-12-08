import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_health/controller/DatabaseController.dart';
import 'package:pet_health/screens/DataModel.dart';
import 'package:pet_health/screens/ApiScreen.dart';

class AddAnimal extends StatefulWidget {
  final Function(Animal) onAnimalAdded;
  AddAnimal({required this.onAnimalAdded});

  @override
  _AddAnimalFormState createState() => _AddAnimalFormState();
}

class _AddAnimalFormState extends State<AddAnimal> {
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _speciesController = TextEditingController();
  bool isExpenseFormVisible = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('Add Animal'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.date_range),
            title: TextField(
              controller: _speciesController,
              decoration: InputDecoration(labelText: 'Spesies'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Ambil data dari input
              final name = _nameController.text;
              final gender = _genderController.text;
              final species = _speciesController.text;

              // Buat objek Expense
              if (name.isNotEmpty) {
                final animal = Animal(
                  name: name,
                  gender: gender,
                  species: species,
                );

                // Dapatkan instance dari DatabaseController
                DatabaseController databaseController =
                    Get.find<DatabaseController>();

                // Panggil fungsi addExpenseToAppwrite dengan expense yang baru
                databaseController.addAnimalToAppwrite(animal);

                // Bersihkan input fields
                _nameController.clear();
                _genderController.clear();
                _speciesController.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }
            },
            child: Text('Add Animal'),
          ),
        ],
      ),
    );
  }
}
