import 'dart:convert';
import 'package:http/http.dart';
import 'package:nyobadoang/entity/membership.dart'; // Import the Membership class

class MembershipClient {
  static final String url = '10.0.2.2:8000'; // Change this to your API URL
  static final String endpoint = '/api/memberships'; // Adjust the endpoint as necessary

  // Fetch all memberships
  static Future<List<Membership>> fetchAll() async {
    try {
      var response = await get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Membership.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Find membership by ID (assuming packageName is used as ID)
  static Future<Membership> find(String id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Membership.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Create a new membership
  static Future<Response> create(Membership membership) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: membership.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase); // HTTP 201 Created

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update an existing membership
  static Future<Response> update(Membership membership) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${membership.packageName}'), // Assuming packageName is used as ID
        headers: {"Content-Type": "application/json"},
        body: membership.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Delete a membership by ID (using packageName as ID)
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
