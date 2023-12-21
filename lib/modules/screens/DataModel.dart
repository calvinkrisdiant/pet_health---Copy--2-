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
  });

  List<Object> get props => [name, gender, species];
  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      gender: json['gender'],
      species: json['species']
    );
  }
}

class AnimalModel with ChangeNotifier {
  List<Animal> expenses = [];
  late final Databases database;

  void addExpense(Animal expense) async {
    expenses.add(expense);
    notifyListeners();
  }
}
