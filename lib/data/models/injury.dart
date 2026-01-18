import 'package:hive/hive.dart';

part 'injury.g.dart';

@HiveType(typeId: 6)
class Injury {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String whatIs;

  @HiveField(3)
  final String whyHappens;

  @HiveField(4)
  final List<String> redFlags;

  @HiveField(5)
  final String commonCare;

  @HiveField(6)
  final String prevention;

  @HiveField(7)
  final String progressiveReturn;

  Injury({
    required this.id,
    required this.name,
    required this.whatIs,
    required this.whyHappens,
    required this.redFlags,
    required this.commonCare,
    required this.prevention,
    required this.progressiveReturn,
  });

  factory Injury.fromJson(Map<String, dynamic> json) {
    return Injury(
      id: json['id'] as String,
      name: json['name'] as String,
      whatIs: json['whatIs'] as String,
      whyHappens: json['whyHappens'] as String,
      redFlags: List<String>.from(json['redFlags'] as List? ?? []),
      commonCare: json['commonCare'] as String,
      prevention: json['prevention'] as String,
      progressiveReturn: json['progressiveReturn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'whatIs': whatIs,
      'whyHappens': whyHappens,
      'redFlags': redFlags,
      'commonCare': commonCare,
      'prevention': prevention,
      'progressiveReturn': progressiveReturn,
    };
  }
}
