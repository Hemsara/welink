import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/services/network_service.dart';

import '../res/constants.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final NetworkService _networkService =
      NetworkService(baseURL: '${AppConstants.host}/api');

  Future<Response> login(String username, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));
      Response res = await _networkService.post(
          mustAuthenticated: false,
          endpoint: '/login/',
          data: {"username": username, "password": password});
      if (res.status == ResponseStatus.success) {
        const storage = FlutterSecureStorage();
        await storage.deleteAll();
        await storage.write(key: 'token', value: res.data!['token']);
      }

      _isLoading = false;
      notifyListeners();
      return res;
    } on SocketException {
      _isLoading = false;
      notifyListeners();
      return Response(
          status: ResponseStatus.failed,
          errors: ["Unable to connect to the server"]);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Response(status: ResponseStatus.failed, errors: [e.toString()]);
    }
  }

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
      return Response(status: ResponseStatus.failed, errors: [e.toString()]);
    }
  }
}
