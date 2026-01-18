import 'package:hive/hive.dart';

part 'position_trail.g.dart';

@HiveType(typeId: 12)
class PositionTrail {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String> regionsFocus;

  @HiveField(3)
  final List<String> cardIds;

  @HiveField(4)
  final List<String> routineIds;

  PositionTrail({
    required this.id,
    required this.name,
    required this.regionsFocus,
    required this.cardIds,
    required this.routineIds,
  });

  factory PositionTrail.fromJson(Map<String, dynamic> json) {
    return PositionTrail(
      id: json['id'] as String,
      name: json['name'] as String,
      regionsFocus: List<String>.from(json['regionsFocus'] as List? ?? []),
      cardIds: List<String>.from(json['cardIds'] as List? ?? []),
      routineIds: List<String>.from(json['routineIds'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'regionsFocus': regionsFocus,
      'cardIds': cardIds,
      'routineIds': routineIds,
    };
  }
}
