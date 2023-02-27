// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:we_link_app/models/links/link.dart';
import 'package:we_link_app/models/links/link_profile.dart';
import 'package:we_link_app/models/links/style.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/services/network_service.dart';

import '../res/constants.dart';

class LinkProvider extends ChangeNotifier {
  final NetworkService _networkService =
      NetworkService(baseURL: '${AppConstants.host}/api');
  bool _fetching = false;
  bool _saving = false;

  bool get fetching => _fetching;
  bool get saving => _saving;

  late LinkProfile _profile;
  late List<Style> _styles;

  LinkProfile get profile => _profile;
  List<Style> get styles => _styles;

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

  Future getStyles() async {
    try {
      _fetching = true;
      Response res = await _networkService.get(
          mustAuthenticated: true, endpoint: '/styles');
      var data = res.data!['data'];
      _styles = List<Style>.from(data.map((e) => Style.fromJson(e)).toList());
      _fetching = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<Response> updateProfile({required Map<String, dynamic> data}) async {
    try {
      _saving = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));
      Response res = await _networkService.update(
          data: data, mustAuthenticated: true, endpoint: '/profile/update');
      _saving = false;
      notifyListeners();

      return res;
    } catch (e) {
      return Response(status: ResponseStatus.failed, errors: [e.toString()]);
    }
  }

  Future<Response> saveLink({required Map<String, dynamic> data}) async {
    try {
      _saving = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));
      Response res = await _networkService.post(
          data: data, mustAuthenticated: true, endpoint: '/links/create/');
      profile.links.add(LinkModel.fromJson(res.data!));
      _saving = false;
      notifyListeners();
      return res;
    } catch (e) {
      return Response(status: ResponseStatus.failed, errors: [e.toString()]);
    }
  }

  Future<Response> updateVisibility(int id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      Response res = await _networkService.update(
          data: {},
          mustAuthenticated: true,
          endpoint: '/links/updateVisibility/$id');
      return res;
    } catch (e) {
      return Response(status: ResponseStatus.failed, errors: [e.toString()]);
    }
  }
}
