import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/models/person/person_info_model.dart';
import '../../domain/entities/message.dart';
import '../../domain/mappers/mappers.dart';

import '../../../../core/domain/entities/person/person_info.dart';

class MessageModel extends Message {
  MessageModel({
    required super.date,
    required super.sender,
    required super.receiver,
    required super.likes,
    required super.replies,
    required super.id,
    super.imageUrl,
    super.text,
    super.videoUrl,
  });
  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
        id: map['id'],
        date: map['date'],
        text: map['text'],
        imageUrl: map['imageUrl'],
        videoUrl: map['videoUrl'],
        likes: List<PersonInfo>.from(
          map['likes'].map((e) => PersonInfoModel.fromMap(e).toDomain()),
        ),
        replies: List<Message>.from(
          map['replies'].map((e) => MessageModel.fromMap(e).toDomain()),
        ),
        receiver: PersonInfoModel.fromMap(map['receiver']),
        sender: PersonInfoModel.fromMap(map['sender']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'text': text,
        'imageUrl': imageUrl,
        'videoUrl': videoUrl,
        'likes': likes.map((e) => e.fromDomain().toMap()).toList(),
        'replies': replies.map((e) => e.fromDomain().toMap()).toList(),
        'receiver': receiver.fromDomain().toMap(),
        'sender': sender.fromDomain().toMap(),
      };
}
