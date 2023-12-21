import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import 'package:pet_health/modules/controller/ClientController.dart';
import 'package:pet_health/modules/screens/DataModel.dart';

class DatabaseController extends ClientController {
  late final Databases database;
  late Function() refreshCallback;

  void setRefreshCallback(Function() callback) {
    refreshCallback = callback; // Atur fungsi callback
  }

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi koneksi ke Appwrite di sini
    database = Databases(client);
  }

  Future<void> addAnimalToAppwrite(Animal animal) async {
    try {
      final data = {
        'namahewan': animal.name,
        'jeniskelamin': animal.gender,
        'spesieshewan': animal.species,

      };

      final response = await database.createDocument(
        collectionId: "656ff43f80cc6cf75c58",// Ganti dengan ID koleksi di Appwrite
        data: data,
        databaseId: '656ff3ddf38af4acac21',
        documentId: ID.unique(),
      );

      print('Expense added to Appwrite: ${response.data}');
    } catch (e) {
      print('Error adding expense to Appwrite: $e');
    }
  }

  Future<List<Document>> getAnimalFromAppwrite() async {
    try {
      final response = await database.listDocuments(
        collectionId: "656ff43f80cc6cf75c58",
        databaseId: '656ff3ddf38af4acac21',
      );

      return response.documents;
    } catch (error) {
      print("Error retrieving expenses: $error");
      return [];
    }
  }


  Future<void> updateAnimalInAppwrite(String documentId,
      Animal animal) async {
    try {
      final data = {
     'namahewan': animal.name,
     'jeniskelamin': animal.gender,
     'spesieshewan': animal.species,
      };
      final response = await database.updateDocument(
        collectionId: '656ff43f80cc6cf75c58',
        // Ganti dengan ID koleksi di Appwrite
        databaseId: '656ff3ddf38af4acac21',
        documentId: documentId,
        // ID dokumen yang akan diperbarui
        data: data,
      );

      print('Expense updated in Appwrite: ${response.data}');
    } catch (e) {
      print('Error updating expense in Appwrite: $e');
    }
  }

  Future<void> deleteAnimalFromAppwrite(String documentId) async {
    try {
      final response = await database.deleteDocument(
         collectionId: '656ff43f80cc6cf75c58',
        // Ganti dengan ID koleksi di Appwrite
        databaseId: '656ff3ddf38af4acac21',
        documentId: documentId, // ID dokumen yang akan dihapus
      );

      print('Expense deleted from Appwrite: ${response.data}');
    } catch (e) {
      print('Error deleting expense from Appwrite: $e');
    }
  }
}
