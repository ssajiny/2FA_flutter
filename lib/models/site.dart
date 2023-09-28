import 'dart:convert';

class Site {
  final int? id;
  final String name;
  final String description;

  Site({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) => Site.fromMap(json.decode(source));

  @override
  String toString() => 'Site(id: $id, name: $name, description: $description)';
}
