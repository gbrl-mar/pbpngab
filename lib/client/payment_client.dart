import 'dart:convert';
import 'package:http/http.dart';
import 'package:nyobadoang/entity/payment.dart'; // Import the Payment class

class PaymentClient {
  static final String url = '10.0.2.2:8000'; // Change this to your API URL
  static final String endpoint = '/api/payments'; // Adjust the endpoint as necessary

  // Fetch all payments
  static Future<List<Payment>> fetchAll() async {
    try {
      var response = await get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Payment.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Find payment by ID (assuming ID is part of the Payment entity)
  static Future<Payment> find(String id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Payment.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Create a new payment
  static Future<Response> create(Payment payment) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: payment.toRawJson(),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase); // HTTP 201 Created

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update an existing payment
  static Future<Response> update(Payment payment) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${payment.idMember}'), // Assuming idMember is used as ID
        headers: {"Content-Type": "application/json"},
        body: payment.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Delete a payment by ID (using idMember as ID)
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
