
/*
import 'package:get/instance_manager.dart';
import 'package:mockito/mockito.dart';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_health/data/api/api_service.dart';
import 'package:pet_health/modules/screens/DataModel.dart';

class MockClient extends Mock with http.BaseClient {}

void main() {
  http.Client client = MockClient();

  test("test ambil data", () async {
    apiServices dataModel = Get.put(apiServices());
    String name = "dika";
    // ignore: prefer_interpolation_to_compose_strings
    when(client.get(("../DataModel/" + name)))
        .thenAnswer((_) async => Future.value(http.Response('''
    {
      "name": $name,
      "gender": "betina",
      "species": "ikan barunang"
    }
    ''', 200)));
    Animal animal = await apiServices.getAnimalByName(name, client);
    expect(
        animal,
        equals(
            Animal(name: "dika", gender: "betina", species: "ikan barunang")));
  });
}*/
