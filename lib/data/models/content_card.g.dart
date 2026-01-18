// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContentCardAdapter extends TypeAdapter<ContentCard> {
  @override
  final int typeId = 1;

  @override
  ContentCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentCard(
      id: fields[0] as String,
      title: fields[1] as String,
      body: fields[2] as String,
      tags: (fields[3] as List).cast<String>(),
      safetyExitRequired: fields[4] as bool,
      disclaimerRequired: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ContentCard obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.safetyExitRequired)
      ..writeByte(5)
      ..write(obj.disclaimerRequired);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
