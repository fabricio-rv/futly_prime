import 'package:hive/hive.dart';

part 'routine.g.dart';

@HiveType(typeId: 2)
class RoutineStep {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final List<String> tags;

  RoutineStep({
    required this.id,
    required this.title,
    required this.body,
    this.tags = const [],
  });

  factory RoutineStep.fromJson(Map<String, dynamic> json) {
    return RoutineStep(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      tags: List<String>.from(json['tags'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body, 'tags': tags};
  }
}

@HiveType(typeId: 3)
class Routine {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<RoutineStep> steps;

  Routine({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      steps: (json['steps'] as List? ?? [])
          .map((s) => RoutineStep.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'steps': steps.map((s) => s.toJson()).toList(),
    };
  }
}
