// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoriesAdapter extends TypeAdapter<Stories> {
  @override
  final int typeId = 4;

  @override
  Stories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stories(
      (fields[0] as List).cast<Story>(),
    );
  }

  @override
  void write(BinaryWriter writer, Stories obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.stories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
