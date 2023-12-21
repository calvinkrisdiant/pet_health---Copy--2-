import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_health/modules/view/AddAnimal.dart';
 // Sesuaikan dengan path yang sesuai

void main() {
  testWidgets('AddAnimal UI Test', (WidgetTester tester) async {
    // Build AddExpenseForm widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AddAnimal(
          onAnimalAdded: (expense) {},
        ),
      ),
    ));

    // Verifikasi bahwa widget AddExpenseForm dan elemennya telah dirender dengan benar
    expect(find.byType(AddAnimal), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4)); // 6 ListTiles
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Coba memasukkan nilai pada TextField dan tekan tombol
    await tester.enterText(find.byType(TextField).at(0), 'Test Name');
    await tester.enterText(find.byType(TextField).at(1), 'Test Gender');
    await tester.enterText(find.byType(TextField).at(2), 'Test Species');


    // Tekan tombol Add Expense
 

// Pastikan teks yang dimasukkan muncul setelah tombol ditekan
    expect(find.text('Test Name'), findsOneWidget);
  
  });
}