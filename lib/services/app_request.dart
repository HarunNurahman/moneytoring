import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;

class AppRequest {
  // GET
  // Data response
  static Future<Map?> get(
    String url,
    Map<String, String>? headers,
  ) async {
    // Execute response
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      // Check response / status code
      DMethod.printTitle('try - $url', response.body);

      // Parsing to Map
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      DMethod.printTitle('catch', e.toString());
      return null;
    }
  }

  // POST
  static Future<Map?> post(
    String url,
    Object? body, {
    Map<String, String>? headers,
  }) async {
    // Execute response
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: headers);
      // Check response / status code
      DMethod.printTitle('try - $url', response.body);

      // Parsing to Map
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      DMethod.printTitle('catch', e.toString());
      return null;
    }
  }
}
