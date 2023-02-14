// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_text.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryTextAdapter extends TypeAdapter<StoryText> {
  @override
  final int typeId = 2;

  @override
  StoryText read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryText(
      text: fields[0] as String,
      fontSize: fields[1] as double,
      color: fields[2] as String,
      dx: fields[3] as double,
      dy: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, StoryText obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.fontSize)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.dx)
      ..writeByte(4)
      ..write(obj.dy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
