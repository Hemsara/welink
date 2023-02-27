import 'package:flutter/material.dart';
import 'package:we_link_app/models/links/link.dart';
import 'package:we_link_app/models/links/style.dart';
import 'package:we_link_app/models/others/user.dart';

class LinkProfileFields {
  static const String id = "id";
  static const String user = "user";
  static const String profileTitle = "profile_title";
  static const String description = "description";
  static const String views = "views";
  static const String gradientUp = "gradient_up";
  static const String clicks = "clicks";
  static const String links = "links";
  static const String avatar = "avatar";
  static const String style = "style";
  static const String radius = "radius";
  static const String flatColor = "flat_color";
  static const String bgColor = "color_hex";
}

class LinkProfile {
  final int id;
  final User user;
  final String profileTitle;
  final String description;
  final int views;
  final int radius;
  final bool gradient_up;
  final bool flatColor;
  final Color bgColor;
  final int clicks;
  final List<LinkModel> links;
  final String? avatar;
  final Style style;
  LinkProfile({
    required this.id,
    required this.style,
    required this.flatColor,
    required this.user,
    required this.clicks,
    required this.profileTitle,
    required this.radius,
    required this.gradient_up,
    required this.description,
    required this.bgColor,
    required this.views,
    required this.links,
    required this.avatar,
  });
  factory LinkProfile.fromJson(Map<String, dynamic> parsedJson) {
    List linksJson = parsedJson[LinkProfileFields.links] as List;
    List<LinkModel> links =
        linksJson.map((e) => LinkModel.fromJson(e)).toList();

    return LinkProfile(
        id: parsedJson[LinkProfileFields.id],
        radius: parsedJson[LinkProfileFields.radius],
        bgColor:
            Color(int.parse('0xff${parsedJson[LinkProfileFields.bgColor]}')),
        clicks: parsedJson[LinkProfileFields.clicks],
        flatColor: parsedJson[LinkProfileFields.flatColor],
        style: Style.fromJson(parsedJson[LinkProfileFields.style]),
        gradient_up: parsedJson[LinkProfileFields.gradientUp],
        user: User.fromJson(parsedJson[LinkProfileFields.user]),
        profileTitle: parsedJson[LinkProfileFields.profileTitle],
        description: parsedJson[LinkProfileFields.description] ?? "",
        views: parsedJson[LinkProfileFields.views] ?? 0,
        links: links,
        avatar: parsedJson[LinkProfileFields.avatar]);
  }
}
