// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaAdapter extends TypeAdapter<Area> {
  @override
  final int typeId = 0;

  @override
  Area read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Area(
      id: fields[0] as String,
      title: fields[1] as String,
      iconKey: fields[2] as String,
      intro: fields[3] as String,
      route: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Area obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.iconKey)
      ..writeByte(3)
      ..write(obj.intro)
      ..writeByte(4)
      ..write(obj.route);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
