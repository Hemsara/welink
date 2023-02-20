class LinkModel {
  final int id;
  final String label;
  final String href;
  final String icon;
  final int clicks;
  LinkModel({
    required this.id,
    required this.label,
    required this.href,
    required this.icon,
    required this.clicks,
  });
  factory LinkModel.fromJson(Map<String, dynamic> parsedJson) {
    return LinkModel(
        id: parsedJson['id'],
        label: parsedJson['label'],
        href: parsedJson['href'],
        icon: parsedJson['icon'],
        clicks: parsedJson['clicks']);
  }
}
