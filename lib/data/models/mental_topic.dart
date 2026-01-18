import 'package:hive/hive.dart';

part 'mental_topic.g.dart';

@HiveType(typeId: 8)
class BreathingTool {
  @HiveField(0)
  final int durationSeconds;

  @HiveField(1)
  final String description;

  BreathingTool({
    required this.durationSeconds,
    required this.description,
  });

  factory BreathingTool.fromJson(Map<String, dynamic> json) {
    return BreathingTool(
      durationSeconds: json['durationSeconds'] as int? ?? 60,
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'durationSeconds': durationSeconds,
      'description': description,
    };
  }
}

@HiveType(typeId: 9)
class MentalTool {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final int durationSeconds;

  @HiveField(2)
  final List<String> scriptSteps;

  MentalTool({
    required this.type,
    required this.durationSeconds,
    required this.scriptSteps,
  });

  factory MentalTool.fromJson(Map<String, dynamic> json) {
    return MentalTool(
      type: json['type'] as String,
      durationSeconds: json['durationSeconds'] as int? ?? 60,
      scriptSteps: List<String>.from(json['scriptSteps'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'durationSeconds': durationSeconds,
      'scriptSteps': scriptSteps,
    };
  }
}

@HiveType(typeId: 10)
class MentalTopic {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String intro;

  @HiveField(3)
  final List<String> reminders;

  @HiveField(4)
  final MentalTool? tool;

  MentalTopic({
    required this.id,
    required this.title,
    required this.intro,
    required this.reminders,
    this.tool,
  });

  factory MentalTopic.fromJson(Map<String, dynamic> json) {
    return MentalTopic(
      id: json['id'] as String,
      title: json['title'] as String,
      intro: json['intro'] as String,
      reminders: List<String>.from(json['reminders'] as List? ?? []),
      tool: json['tool'] != null
          ? MentalTool.fromJson(json['tool'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'intro': intro,
      'reminders': reminders,
      'tool': tool?.toJson(),
    };
  }
}
