// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonInfoAdapter extends TypeAdapter<PersonInfo> {
  @override
  final int typeId = 1;

  @override
  PersonInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonInfo(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
      uid: fields[2] as String,
      localImagePath: fields[3] as String,
      username: fields[4] as String,
      email: fields[6] as String,
      gender: fields[8] as String,
      bio: fields[7] as String?,
      isVerified: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PersonInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.localImagePath)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.isVerified)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.bio)
      ..writeByte(8)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
