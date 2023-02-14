// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram_clone/src/core/domain/entities/person/person_info.dart';

part 'message.g.dart';

@HiveType(typeId: 13)
class Message extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? text;
  @HiveField(1)
  final String? imageUrl;
  @HiveField(2)
  final String? videoUrl;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final PersonInfo sender;
  @HiveField(5)
  final PersonInfo receiver;
  @HiveField(6)
  final List<PersonInfo> likes;
  @HiveField(7)
  final List<Message> replies;
  @HiveField(8)
  final String id;

  Message({
    this.text,
    this.imageUrl,
    this.videoUrl,
    required this.date,
    required this.sender,
    required this.receiver,
    required this.likes,
    required this.replies,
    required this.id,
  });

  @override
  List<Object?> get props => [
        text,
        imageUrl,
        videoUrl,
        date,
        sender,
        receiver,
        likes,
        replies,
        id,
      ];

  Message copyWith({
    String? text,
    String? imageUrl,
    String? videoUrl,
    String? date,
    PersonInfo? sender,
    PersonInfo? receiver,
    List<PersonInfo>? likes,
    List<Message>? replies,
    String? id,
  }) {
    return Message(
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      date: date ?? this.date,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      likes: likes ?? this.likes,
      replies: replies ?? this.replies,
      id: id ?? this.id,
    );
  }
}
