import 'dart:convert';
import 'package:http/http.dart';
import 'package:nyobadoang/entity/equipment.dart'; // Import the Equipment class

class EquipmentClient {
  static final String url = '10.0.2.2:8000'; // Change this to your API URL
  static final String endpoint = '/api/equipment'; // Adjust the endpoint as necessary

  // Fetch all equipment
  static Future<List<Equipment>> fetchAll() async {
    try {
      var response = await get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Equipment.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Find equipment by ID (assuming name is used as ID)
  static Future<Equipment> find(String id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Equipment.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Create a new equipment
  static Future<Response> create(Equipment equipment) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: equipment.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase); // HTTP 201 Created

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update an existing equipment
  static Future<Response> update(Equipment equipment) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${equipment.name}'), // Assuming name is used as ID
        headers: {"Content-Type": "application/json"},
        body: equipment.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Delete equipment by ID (using name as ID)
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
