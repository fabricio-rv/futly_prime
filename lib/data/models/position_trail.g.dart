// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_trail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionTrailAdapter extends TypeAdapter<PositionTrail> {
  @override
  final int typeId = 12;

  @override
  PositionTrail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionTrail(
      id: fields[0] as String,
      name: fields[1] as String,
      regionsFocus: (fields[2] as List).cast<String>(),
      cardIds: (fields[3] as List).cast<String>(),
      routineIds: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PositionTrail obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.regionsFocus)
      ..writeByte(3)
      ..write(obj.cardIds)
      ..writeByte(4)
      ..write(obj.routineIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionTrailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
