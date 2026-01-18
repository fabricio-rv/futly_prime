import 'package:hive/hive.dart';

part 'area.g.dart';

@HiveType(typeId: 0)
class Area {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String iconKey;

  @HiveField(3)
  final String intro;

  @HiveField(4)
  final String route;

  Area({
    required this.id,
    required this.title,
    required this.iconKey,
    required this.intro,
    required this.route,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'] as String,
      title: json['title'] as String,
      iconKey: json['iconKey'] as String,
      intro: json['intro'] as String,
      route: json['route'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'iconKey': iconKey,
      'intro': intro,
      'route': route,
    };
  }
}
