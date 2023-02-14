// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryAdapter extends TypeAdapter<Story> {
  @override
  final int typeId = 3;

  @override
  Story read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Story(
      publisher: fields[0] as PersonInfo,
      viewers: (fields[2] as List).cast<PersonInfo>(),
      storyDate: fields[7] as String,
      id: fields[8] as String,
      storyText: fields[1] as StoryText?,
      imageUrl: fields[3] as String?,
      imageLocalPath: fields[4] as String?,
      videoUrl: fields[5] as String?,
      videoLocalPath: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Story obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.publisher)
      ..writeByte(1)
      ..write(obj.storyText)
      ..writeByte(2)
      ..write(obj.viewers)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.imageLocalPath)
      ..writeByte(5)
      ..write(obj.videoUrl)
      ..writeByte(6)
      ..write(obj.videoLocalPath)
      ..writeByte(7)
      ..write(obj.storyDate)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
