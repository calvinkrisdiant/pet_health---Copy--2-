



import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class Animal {
  final String name;
  final String gender;
  final String species;
  

  Animal({
    required this.name,
    required this.gender,
    required this.species,
    }
    );
}
class AnimalModel with ChangeNotifier {
  List<Animal> expenses = [];
  late final Databases database;

  void addExpense(Animal expense) async{
    expenses.add(expense);
    notifyListeners();
  }
}