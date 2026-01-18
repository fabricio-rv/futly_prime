// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mental_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreathingToolAdapter extends TypeAdapter<BreathingTool> {
  @override
  final int typeId = 8;

  @override
  BreathingTool read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BreathingTool(
      durationSeconds: fields[0] as int,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BreathingTool obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.durationSeconds)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreathingToolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MentalToolAdapter extends TypeAdapter<MentalTool> {
  @override
  final int typeId = 9;

  @override
  MentalTool read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MentalTool(
      type: fields[0] as String,
      durationSeconds: fields[1] as int,
      scriptSteps: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MentalTool obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.durationSeconds)
      ..writeByte(2)
      ..write(obj.scriptSteps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentalToolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MentalTopicAdapter extends TypeAdapter<MentalTopic> {
  @override
  final int typeId = 10;

  @override
  MentalTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MentalTopic(
      id: fields[0] as String,
      title: fields[1] as String,
      intro: fields[2] as String,
      reminders: (fields[3] as List).cast<String>(),
      tool: fields[4] as MentalTool?,
    );
  }

  @override
  void write(BinaryWriter writer, MentalTopic obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.intro)
      ..writeByte(3)
      ..write(obj.reminders)
      ..writeByte(4)
      ..write(obj.tool);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentalTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
