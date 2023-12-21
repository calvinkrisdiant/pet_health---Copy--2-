import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:pet_health/modules/screens/DataModel.dart';

class apiServices {
  static Future<Animal> getAnimalByName(String name, http.Client client) async {
    
    String url = "../DataModel/" + name;
    Uri uri = Uri.parse(url);

    var response = await client.get(uri);
    if(response.statusCode != 200){
      throw Exception("error");
    }
    var result = json.decode(response.body);

    return Animal.fromJson(result);
  }
}
