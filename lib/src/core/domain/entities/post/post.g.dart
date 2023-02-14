// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 6;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post(
      publisher: fields[0] as PersonInfo,
      postMedia: fields[1] as PostMedia,
      postText: fields[2] as String?,
      postDate: fields[3] as String,
      locationInfo: fields[4] as LocationInfo?,
      likes: (fields[5] as List).cast<PersonInfo>(),
      comments: (fields[6] as List).cast<Comment>(),
      taggedPeople: (fields[7] as List).cast<Person>(),
      id: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.publisher)
      ..writeByte(1)
      ..write(obj.postMedia)
      ..writeByte(2)
      ..write(obj.postText)
      ..writeByte(3)
      ..write(obj.postDate)
      ..writeByte(4)
      ..write(obj.locationInfo)
      ..writeByte(5)
      ..write(obj.likes)
      ..writeByte(6)
      ..write(obj.comments)
      ..writeByte(7)
      ..write(obj.taggedPeople)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
