import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:we_link_app/models/others/response.dart';

class NetworkService {
  final String baseURL;
  NetworkService({
    required this.baseURL,
  });

  Future<Response> post(
      {required bool mustAuthenticated,
      required String endpoint,
      required Map<String, dynamic> data}) async {
    try {
      var url = Uri.parse('$baseURL$endpoint');
      FlutterSecureStorage storage = const FlutterSecureStorage();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      if (mustAuthenticated) {
        var value = await storage.read(key: 'token');
        headers["Authorization"] = "Token $value";
      }
      var response = await http.post(
        url,
        body: jsonEncode(data),
        headers: headers,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Response(
            status: ResponseStatus.success, data: jsonDecode(response.body));
      }

      List err = jsonDecode(response.body).values.map((e) => e[0]).toList();

      return Response(status: ResponseStatus.failed, errors: err);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(
      {required bool mustAuthenticated,
      required String endpoint,
      required Map<String, dynamic> data}) async {
    try {
      var url = Uri.parse('$baseURL$endpoint');
      FlutterSecureStorage storage = const FlutterSecureStorage();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      if (mustAuthenticated) {
        var value = await storage.read(key: 'token');
        headers["Authorization"] = "Token $value";
      }
      var response = await http.patch(
        url,
        body: jsonEncode(data),
        headers: headers,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Response(
            status: ResponseStatus.success, data: jsonDecode(response.body));
      }

      List err = jsonDecode(response.body).values.map((e) => e[0]).toList();

      return Response(status: ResponseStatus.failed, errors: err);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get({
    required bool mustAuthenticated,
    required String endpoint,
  }) async {
    try {
      var url = Uri.parse('$baseURL$endpoint');
      FlutterSecureStorage storage = const FlutterSecureStorage();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      if (mustAuthenticated) {
        var value = await storage.read(key: 'token');
        headers["Authorization"] = "Token $value";
      }
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return Response(
            status: ResponseStatus.success, data: jsonDecode(response.body));
      }

      List err = jsonDecode(response.body).values.map((e) => e[0]).toList();

      return Response(
          status: ResponseStatus.failed,
          errors: err,
          data: jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
