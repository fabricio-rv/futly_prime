// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_region.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecoverySectionAdapter extends TypeAdapter<RecoverySection> {
  @override
  final int typeId = 4;

  @override
  RecoverySection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecoverySection(
      title: fields[0] as String,
      items: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecoverySection obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecoverySectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecoveryRegionAdapter extends TypeAdapter<RecoveryRegion> {
  @override
  final int typeId = 5;

  @override
  RecoveryRegion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecoveryRegion(
      id: fields[0] as String,
      name: fields[1] as String,
      sections: (fields[2] as List).cast<RecoverySection>(),
      redFlags: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecoveryRegion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sections)
      ..writeByte(3)
      ..write(obj.redFlags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecoveryRegionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
