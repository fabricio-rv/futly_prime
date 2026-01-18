import 'package:hive/hive.dart';

part 'recovery_region.g.dart';

@HiveType(typeId: 4)
class RecoverySection {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final List<String> items;

  RecoverySection({
    required this.title,
    required this.items,
  });

  factory RecoverySection.fromJson(Map<String, dynamic> json) {
    return RecoverySection(
      title: json['title'] as String,
      items: List<String>.from(json['items'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'items': items,
    };
  }
}

@HiveType(typeId: 5)
class RecoveryRegion {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<RecoverySection> sections;

  @HiveField(3)
  final List<String> redFlags;

  RecoveryRegion({
    required this.id,
    required this.name,
    required this.sections,
    required this.redFlags,
  });

  factory RecoveryRegion.fromJson(Map<String, dynamic> json) {
    return RecoveryRegion(
      id: json['id'] as String,
      name: json['name'] as String,
      sections: (json['sections'] as List? ?? [])
          .map((s) => RecoverySection.fromJson(s as Map<String, dynamic>))
          .toList(),
      redFlags: List<String>.from(json['redFlags'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sections': sections.map((s) => s.toJson()).toList(),
      'redFlags': redFlags,
    };
  }
}
