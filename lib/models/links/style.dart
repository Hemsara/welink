class Style {
  final int id;
  final String name;
  final bool isFilled;
  final bool isHardShadow;
  final bool isSoftShadow;

  Style({
    required this.id,
    required this.name,
    required this.isFilled,
    required this.isHardShadow,
    required this.isSoftShadow,
  });
  factory Style.fromJson(Map<String, dynamic> parsedJson) {
    return Style(
      id: parsedJson['id'],
      name: parsedJson['name'],
      isFilled: parsedJson['isFilled'],
      isHardShadow: parsedJson['isHardShadow'],
      isSoftShadow: parsedJson['isSoftShadow'],
    );
  }
}
