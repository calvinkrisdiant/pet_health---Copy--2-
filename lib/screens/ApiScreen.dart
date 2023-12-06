import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:pet_health/controller/DatabaseController.dart';
import 'package:pet_health/screens/DataModel.dart';
import 'package:pet_health/view/AddAnimal.dart';
import 'package:pet_health/view/UpdateAnimal.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite CRUD Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isExpenseFormVisible = false;
  late List<Document> appwriteAnimal = [];
  late DatabaseController database = DatabaseController();
  
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    database = Get.find<DatabaseController>();
    refreshAnimal();
    fetchAppwriteAnimal();
  }

  Future<void> fetchAppwriteAnimal() async {
    final databaseController = Get.find<DatabaseController>();
    final expenses = await databaseController.getAnimalFromAppwrite();
    setState(() {
      appwriteAnimal = expenses;
    });
  }

  void toggleExpenseFormVisibility() {
    setState(() {
      isExpenseFormVisible = !isExpenseFormVisible;
    });
  }

 void _editAnimal(Document document) {
    Get.to(AnimalEdit(
      existingAnimal: Animal(
        name: document.data['namahewan'],
        gender: document.data['jeniskelamin'],
        species: document.data['spesieshewan'],
      ),
      onAnimalAdded: (editedAnimal) async {
        await database.updateAnimalInAppwrite(document.$id, editedAnimal);
        fetchAppwriteAnimal(); // Refresh list after edit
      },
    ));
  }

  Future<void> refreshAnimal() async {
    final expenses = await database.getAnimalFromAppwrite();
    setState(() {
      appwriteAnimal = expenses;
    });
  }

  Future<void> _deleteExpense(Document document) async {
    await database.deleteAnimalFromAppwrite(document.$id);
    setState(() {
      appwriteAnimal.remove(document);
    });
  }

  Future<void> _addExpense(Animal animal) async {
    await database.addAnimalToAppwrite(animal);
    refreshAnimal(); // Perbarui data setelah menambahkan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracking App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: appwriteAnimal.length,
              itemBuilder: (context, index) {
                final document = appwriteAnimal[index];
                final name = document.data['namahewan'];
                final jeniskelamin = document.data['jeniskelamin'];
                final spesies = document.data['spesieshewan'];

                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Choose Action'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text('Update'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _editAnimal(document);
                                  },
                                ),
                                GestureDetector(
                                  child: Text('Delete'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _deleteExpense(document);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ExpansionTile(
                    title: Text(name),
                    children: [
                      ListTile(
                        title: Text('Nama Hewan: $name'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama Hewan: $name'),
                            Text('Spesies: $spesies'),
                            Text('Jenis Kelamin: $jeniskelamin'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            isExpenseFormVisible
                ? AddAnimal(
                    onAnimalAdded: (expense) async {
                      await database.addAnimalToAppwrite(expense);
                      fetchAppwriteAnimal(); // Refresh list after adding new expense
                    },
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleExpenseFormVisibility,
        child: Icon(Icons.add),
      ),
    );
  }
}
