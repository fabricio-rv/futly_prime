// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducationCardAdapter extends TypeAdapter<EducationCard> {
  @override
  final int typeId = 7;

  @override
  EducationCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducationCard(
      id: fields[0] as String,
      title: fields[1] as String,
      summary: fields[2] as String,
      body: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EducationCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.summary)
      ..writeByte(3)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
