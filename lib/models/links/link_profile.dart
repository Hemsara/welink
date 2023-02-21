import 'package:we_link_app/models/links/link.dart';
import 'package:we_link_app/models/others/user.dart';

class LinkProfile {
  final int id;
  final User user;
  final String profileTitle;
  final String description;
  final int views;
  final int clicks;
  final List<LinkModel> links;
  final String? avatar;
  LinkProfile({
    required this.id,
    required this.user,
    required this.clicks,
    required this.profileTitle,
    required this.description,
    required this.views,
    required this.links,
    required this.avatar,
  });
  factory LinkProfile.fromJson(Map<String, dynamic> parsedJson) {
    List linksJson = parsedJson['links'] as List;
    List<LinkModel> links =
        linksJson.map((e) => LinkModel.fromJson(e)).toList();

    return LinkProfile(
        id: parsedJson['id'],
        clicks: parsedJson['clicks'],
        user: User.fromJson(parsedJson['user']),
        profileTitle: parsedJson['profile_title'],
        description: parsedJson['description'] ?? "",
        views: parsedJson['views'] ?? 0,
        links: links,
        avatar: parsedJson['avatar']);
  }
}
