// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:we_link_app/models/links/link_profile.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/services/network_service.dart';

class LinkProvider extends ChangeNotifier {
  final NetworkService _networkService =
      NetworkService(baseURL: 'http://127.0.0.1:8000/api');
  bool _fetching = false;

  bool get fetching => _fetching;
  late LinkProfile _profile;
  LinkProfile get profile => _profile;

  Future getOverview() async {
    try {
      _fetching = true;
      Response res = await _networkService.get(
          mustAuthenticated: true, endpoint: '/overview');
      var data = res.data!['data'];
      _profile = LinkProfile.fromJson(data);
      _fetching = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
