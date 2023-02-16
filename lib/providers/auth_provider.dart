import 'package:flutter/material.dart';
import 'package:we_link_app/models/response.dart';
import 'package:we_link_app/services/network_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final NetworkService _networkService =
      NetworkService(baseURL: 'http://127.0.0.1:8000/api');
  Future<Response> createUser(
      {required String email,
      required String username,
      required String password}) async {
    try {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      Response rs = await _networkService
          .post(mustAuthenticated: false, endpoint: '/register/', data: {
        "username": username,
        "email": email,
        "password": password,
      });
      _isLoading = false;
      notifyListeners();
      return rs;
    } catch (e) {
      return Response(
          status: ResponseStatus.failed,
          errors: ["something went wrong"]);
    }
  }
}
