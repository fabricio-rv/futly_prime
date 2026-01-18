import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/area.dart';
import '../models/recovery_region.dart';
import '../models/injury.dart';
import '../models/education_card.dart';
import '../models/routine.dart';
import '../models/mental_topic.dart';
import '../models/position_trail.dart';

class ContentRepository {
  static final ContentRepository _instance = ContentRepository._internal();

  factory ContentRepository() {
    return _instance;
  }

  ContentRepository._internal();

  // Cache
  List<Area>? _areas;
  List<RecoveryRegion>? _recoveryRegions;
  List<Injury>? _injuries;
  List<EducationCard>? _educationCards;
  List<Routine>? _routines;
  List<MentalTopic>? _mentalTopics;
  List<PositionTrail>? _positionTrails;

  // Load all areas
  Future<List<Area>> getAreas() async {
    if (_areas != null) return _areas!;
    final json = await _loadJson('assets/content/areas.json');
    _areas = (json as List)
        .map((e) => Area.fromJson(e as Map<String, dynamic>))
        .toList();
    return _areas!;
  }

  // Load all recovery regions
  Future<List<RecoveryRegion>> getRecoveryRegions() async {
    if (_recoveryRegions != null) return _recoveryRegions!;
    final json = await _loadJson('assets/content/recovery_regions.json');
    _recoveryRegions = (json as List)
        .map((e) => RecoveryRegion.fromJson(e as Map<String, dynamic>))
        .toList();
    return _recoveryRegions!;
  }

  // Get single recovery region by ID
  Future<RecoveryRegion?> getRecoveryRegion(String regionId) async {
    final regions = await getRecoveryRegions();
    try {
      return regions.firstWhere((r) => r.id == regionId);
    } catch (e) {
      return null;
    }
  }

  // Load all injuries
  Future<List<Injury>> getInjuries() async {
    if (_injuries != null) return _injuries!;
    final json = await _loadJson('assets/content/injuries.json');
    _injuries = (json as List)
        .map((e) => Injury.fromJson(e as Map<String, dynamic>))
        .toList();
    return _injuries!;
  }

  // Get single injury by ID
  Future<Injury?> getInjury(String injuryId) async {
    final injuries = await getInjuries();
    try {
      return injuries.firstWhere((i) => i.id == injuryId);
    } catch (e) {
      return null;
    }
  }

  // Load all education cards
  Future<List<EducationCard>> getEducationCards() async {
    if (_educationCards != null) return _educationCards!;
    final json = await _loadJson('assets/content/education.json');
    _educationCards = (json as List)
        .map((e) => EducationCard.fromJson(e as Map<String, dynamic>))
        .toList();
    return _educationCards!;
  }

  // Get single education card by ID
  Future<EducationCard?> getEducationCard(String eduId) async {
    final cards = await getEducationCards();
    try {
      return cards.firstWhere((c) => c.id == eduId);
    } catch (e) {
      return null;
    }
  }

  // Load all routines
  Future<List<Routine>> getRoutines() async {
    if (_routines != null) return _routines!;
    final json = await _loadJson('assets/content/routines.json');
    _routines = (json as List)
        .map((e) => Routine.fromJson(e as Map<String, dynamic>))
        .toList();
    return _routines!;
  }

  // Get single routine by ID
  Future<Routine?> getRoutine(String routineId) async {
    final routines = await getRoutines();
    try {
      return routines.firstWhere((r) => r.id == routineId);
    } catch (e) {
      return null;
    }
  }

  // Load all mental topics
  Future<List<MentalTopic>> getMentalTopics() async {
    if (_mentalTopics != null) return _mentalTopics!;
    final json = await _loadJson('assets/content/mental_topics.json');
    _mentalTopics = (json as List)
        .map((e) => MentalTopic.fromJson(e as Map<String, dynamic>))
        .toList();
    return _mentalTopics!;
  }

  // Get single mental topic by ID
  Future<MentalTopic?> getMentalTopic(String topicId) async {
    final topics = await getMentalTopics();
    try {
      return topics.firstWhere((t) => t.id == topicId);
    } catch (e) {
      return null;
    }
  }

  // Load all position trails
  Future<List<PositionTrail>> getPositionTrails() async {
    if (_positionTrails != null) return _positionTrails!;
    final json = await _loadJson('assets/content/positions.json');
    _positionTrails = (json as List)
        .map((e) => PositionTrail.fromJson(e as Map<String, dynamic>))
        .toList();
    return _positionTrails!;
  }

  // Get single position trail by ID
  Future<PositionTrail?> getPositionTrail(String posId) async {
    final positions = await getPositionTrails();
    try {
      return positions.firstWhere((p) => p.id == posId);
    } catch (e) {
      return null;
    }
  }

  // Load JSON file
  Future<dynamic> _loadJson(String path) async {
    final data = await rootBundle.loadString(path);
    return jsonDecode(data);
  }

  // Clear cache
  void clearCache() {
    _areas = null;
    _recoveryRegions = null;
    _injuries = null;
    _educationCards = null;
    _routines = null;
    _mentalTopics = null;
    _positionTrails = null;
  }
}
