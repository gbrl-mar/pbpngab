import 'dart:convert';
import 'package:http/http.dart';
import 'package:nyobadoang/entity/cabang.dart'; // Import the Cabang class

class CabangClient {
  static final String url = '10.0.2.2:8000'; // Change this to your API URL
  static final String endpoint = '/api/cabangs'; // Adjust the endpoint as necessary

  // Fetch all cabangs
  static Future<List<Cabang>> fetchAll() async {
    try {
      var response = await get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Cabang.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Find cabang by ID (assuming gymName is used as ID)
  static Future<Cabang> find(String id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Cabang.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Create a new cabang
  static Future<Response> create(Cabang cabang) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: cabang.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase); // HTTP 201 Created

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update an existing cabang
  static Future<Response> update(Cabang cabang) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${cabang.gymName}'), // Assuming gymName is used as ID
        headers: {"Content-Type": "application/json"},
        body: cabang.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Delete a cabang by ID (using gymName as ID)
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
