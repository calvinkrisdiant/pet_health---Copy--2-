import 'package:flutter_test/flutter_test.dart';
import 'package:pet_health/modules/screens/DataModel.dart';

void main() {
  test('Test addAnimal in Datamodel', () {
    // Arrange
    final expenseModel = AnimalModel();
    final initialExpensesLength = expenseModel.expenses.length;
    final animal = Animal(
      name: 'Test Expense',
      gender: 'test gender',
      species: 'Test Species',
    );

    // Act
    expenseModel.addExpense(animal);

    // Assert
    expect(expenseModel.expenses.length, initialExpensesLength + 1);
    expect(expenseModel.expenses.last.name, 'Test Expense');
    expect(expenseModel.expenses.last.gender, 'test gender');
    expect(expenseModel.expenses.last.species, 'Test Species');
    // ...Tambahkan asertif lain sesuai dengan informasi yang diharapkan dari expense yang ditambahkan
  });
}
