import 'package:hive/hive.dart';

part 'education_card.g.dart';

@HiveType(typeId: 7)
class EducationCard {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String summary;

  @HiveField(3)
  final String body;

  EducationCard({
    required this.id,
    required this.title,
    required this.summary,
    required this.body,
  });

  factory EducationCard.fromJson(Map<String, dynamic> json) {
    return EducationCard(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'body': body,
    };
  }
}
