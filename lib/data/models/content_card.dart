import 'package:hive/hive.dart';

part 'content_card.g.dart';

@HiveType(typeId: 1)
class ContentCard {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final List<String> tags;

  @HiveField(4)
  final bool safetyExitRequired;

  @HiveField(5)
  final bool disclaimerRequired;

  ContentCard({
    required this.id,
    required this.title,
    required this.body,
    this.tags = const [],
    this.safetyExitRequired = false,
    this.disclaimerRequired = false,
  });

  factory ContentCard.fromJson(Map<String, dynamic> json) {
    return ContentCard(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      tags: List<String>.from(json['tags'] as List? ?? []),
      safetyExitRequired: json['safetyExitRequired'] as bool? ?? false,
      disclaimerRequired: json['disclaimerRequired'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'safetyExitRequired': safetyExitRequired,
      'disclaimerRequired': disclaimerRequired,
    };
  }
}
