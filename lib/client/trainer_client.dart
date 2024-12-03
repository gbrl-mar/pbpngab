import 'dart:convert';
import 'package:http/http.dart';
import 'package:nyobadoang/entity/trainer.dart'; // Import the Trainer class

class TrainerClient {
  static final String url = '10.0.2.2:8000'; // Change this to your API URL
  static final String endpoint = '/api/trainers'; // Adjust the endpoint as necessary

  // Fetch all trainers
  static Future<List<Trainer>> fetchAll() async {
    try {
      var response = await get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Trainer.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Find trainer by ID
  static Future<Trainer> find(String id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Trainer.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Create a new trainer
  static Future<Response> create(Trainer trainer) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: trainer.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase); // HTTP 201 Created

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update an existing trainer
  static Future<Response> update(Trainer trainer) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${trainer.name}'), // Assuming name is used as ID
        headers: {"Content-Type": "application/json"},
        body: trainer.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Delete a trainer by ID (using name as ID)
  static Future<Response> destroy(String id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
