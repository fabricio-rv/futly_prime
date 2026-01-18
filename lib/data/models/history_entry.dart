import 'package:hive/hive.dart';

part 'history_entry.g.dart';

@HiveType(typeId: 11)
class HistoryEntry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type; // 'dor', 'sono', 'observacao'

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final String? regionId;

  @HiveField(4)
  final String? sleepQuality; // 'bad', 'ok', 'good'

  @HiveField(5)
  final int? intensity; // 1-5

  @HiveField(6)
  final String? notes;

  HistoryEntry({
    required this.id,
    required this.type,
    required this.createdAt,
    this.regionId,
    this.sleepQuality,
    this.intensity,
    this.notes,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      id: json['id'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      regionId: json['regionId'] as String?,
      sleepQuality: json['sleepQuality'] as String?,
      intensity: json['intensity'] as int?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'regionId': regionId,
      'sleepQuality': sleepQuality,
      'intensity': intensity,
      'notes': notes,
    };
  }
}
