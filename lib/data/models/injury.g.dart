// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injury.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InjuryAdapter extends TypeAdapter<Injury> {
  @override
  final int typeId = 6;

  @override
  Injury read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Injury(
      id: fields[0] as String,
      name: fields[1] as String,
      whatIs: fields[2] as String,
      whyHappens: fields[3] as String,
      redFlags: (fields[4] as List).cast<String>(),
      commonCare: fields[5] as String,
      prevention: fields[6] as String,
      progressiveReturn: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Injury obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.whatIs)
      ..writeByte(3)
      ..write(obj.whyHappens)
      ..writeByte(4)
      ..write(obj.redFlags)
      ..writeByte(5)
      ..write(obj.commonCare)
      ..writeByte(6)
      ..write(obj.prevention)
      ..writeByte(7)
      ..write(obj.progressiveReturn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InjuryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
