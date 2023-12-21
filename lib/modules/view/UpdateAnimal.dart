import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_health/modules/screens/DataModel.dart';

class AnimalEdit extends StatefulWidget {
  final Function(Animal) onAnimalAdded;
  final Animal existingAnimal; // New property to store existing Animal data

  AnimalEdit({required this.onAnimalAdded, required this.existingAnimal});

  @override
  _AnimalEditState createState() => _AnimalEditState();
}

class _AnimalEditState extends State<AnimalEdit> {
  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _spesiesController;
  bool isExpenseFormVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingAnimal.name);
    _genderController =
        TextEditingController(text: widget.existingAnimal.gender);
    _spesiesController =
        TextEditingController(text: widget.existingAnimal.species);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('Edit Animal'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: TextField(
              controller: _spesiesController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final editedAnimal = Animal(
                name: _nameController.text,
                gender: _genderController.text,
                species: _spesiesController.text,
              );
              widget.onAnimalAdded(editedAnimal);
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Text('Edit Animal'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _spesiesController.dispose();
    super.dispose();
  }
}
