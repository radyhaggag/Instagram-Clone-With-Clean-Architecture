// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostMediaAdapter extends TypeAdapter<PostMedia> {
  @override
  final int typeId = 5;

  @override
  PostMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostMedia(
      imagesUrl: (fields[0] as List).cast<String>(),
      imagesLocalPaths: (fields[1] as List).cast<String>(),
      videosUrl: (fields[2] as List).cast<String>(),
      videosLocalPaths: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostMedia obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imagesUrl)
      ..writeByte(1)
      ..write(obj.imagesLocalPaths)
      ..writeByte(2)
      ..write(obj.videosUrl)
      ..writeByte(3)
      ..write(obj.videosLocalPaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
