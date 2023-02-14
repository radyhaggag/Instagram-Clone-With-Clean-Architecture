import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../../core/domain/mappers/mappers.dart';
import '../../../../../core/firebase/firestore_collections.dart';

import '../../../../../core/firebase/firestore_manager.dart';
import '../../../../../core/models/person/person_info_model.dart';
import '../../../domain/mappers/mappers.dart';
import '../../../domain/usecases/like_reply_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import '../../../domain/usecases/reply_to_message_usecase.dart';
import '../../models/message_model.dart';
import '../../models/chat_model.dart';

import '../../../domain/usecases/like_message_usecase.dart';
import 'base_remote_chat_datasource.dart';

class RemoteChatDatasource implements BaseRemoteChatDatasource {
  RemoteChatDatasource({
    required this.firebaseFirestore,
    required this.auth,
    required this.firestoreManager,
    required this.storage,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;
  final FirestoreManager firestoreManager;
  final FirebaseStorage storage;

  @override
  Future<ChatModel> getChat(String chatId) async {
    try {
      final chatRef = firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(auth.currentUser?.uid)
          .collection(FirestoreCollections.allChats)
          .doc(chatId);
      final doc = await chatRef.get();
      ChatModel chat = ChatModel.fromMap(doc.data()!);
      return chat;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<List<ChatModel>> getChats() {
    try {
      return firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(auth.currentUser!.uid)
          .collection(FirestoreCollections.allChats)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => ChatModel.fromMap(e.data())).toList());
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    try {
      return firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(auth.currentUser?.uid)
          .collection(FirestoreCollections.allChats)
          .doc(chatId)
          .collection(FirestoreCollections.messages)
          .orderBy('date', descending: false)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => MessageModel.fromMap(e.data())).toList());
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MessageModel> likeMessage(LikeMessageParams params) async {
    try {
      List<PersonInfoModel> likes = [];
      final liker = await firestoreManager.getPerson(auth.currentUser!.uid);
      var docRef = firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(liker.personInfo.uid)
          .collection(FirestoreCollections.allChats)
          .doc(params.receiverUid)
          .collection(FirestoreCollections.messages)
          .doc(params.messageId);

      var messageRef = await docRef.get();
      MessageModel messageModel = MessageModel.fromMap(messageRef.data()!);
      likes = messageModel.likes.map((e) => e.fromDomain()).toList();
      List likesUid = likes.map((e) => e.uid).toList();
      if (likesUid.contains(liker.personInfo.uid)) {
        likes.removeWhere((element) => element.uid == liker.personInfo.uid);
      } else {
        likes.add(liker.personInfo.fromDomain());
      }
      docRef.update({'likes': likes.map((e) => e.toMap()).toList()});
      firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(params.receiverUid)
          .collection(FirestoreCollections.allChats)
          .doc(liker.personInfo.uid)
          .collection(FirestoreCollections.messages)
          .doc(params.messageId)
          .update({'likes': likes.map((e) => e.toMap()).toList()});
      return messageModel.copyWith(likes: likes).fromDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageModel> likeReply(LikeReplyParams params) async {
    try {
      List<PersonInfoModel> likes = [];
      final liker = await firestoreManager.getPerson(auth.currentUser!.uid);
      var docRef = firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(liker.personInfo.uid)
          .collection(FirestoreCollections.allChats)
          .doc(params.receiverUid)
          .collection(FirestoreCollections.messages)
          .doc(params.messageId);

      var messageRef = await docRef.get();
      MessageModel messageModel = MessageModel.fromMap(messageRef.data()!);
      MessageModel reply = messageModel.replies
          .firstWhere((element) => element.id == params.replyId)
          .fromDomain();
      int replyIndex = messageModel.replies
          .indexWhere((element) => element.id == params.replyId);
      likes = reply.likes.map((e) => e.fromDomain()).toList();

      List likesUid = likes.map((e) => e.uid).toList();
      if (likesUid.contains(liker.personInfo.uid)) {
        likes.removeWhere((element) => element.uid == liker.personInfo.uid);
      } else {
        likes.add(liker.personInfo.fromDomain());
      }
      reply = reply.copyWith(likes: likes).fromDomain();
      messageModel.replies[replyIndex] = reply;
      docRef.update({
        'replies':
            messageModel.replies.map((e) => e.fromDomain().toMap()).toList()
      });
      firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(params.receiverUid)
          .collection(FirestoreCollections.allChats)
          .doc(liker.personInfo.uid)
          .collection(FirestoreCollections.messages)
          .doc(params.messageId)
          .update({
        'replies':
            messageModel.replies.map((e) => e.fromDomain().toMap()).toList()
      });
      return messageModel.copyWith(likes: likes).fromDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageModel> replyToMessage(ReplyToMessageParams params) async {
    try {
      List<MessageModel> replies = [];
      final replier = await firestoreManager.getPerson(auth.currentUser!.uid);
      var docRef = firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(replier.personInfo.uid)
          .collection(FirestoreCollections.allChats)
          .doc(params.message.receiver.uid)
          .collection(FirestoreCollections.messages)
          .doc(params.messageId);

      var messageRef = await docRef.get();
      MessageModel messageModel = MessageModel.fromMap(messageRef.data()!);
      replies = messageModel.replies.map((e) => e.fromDomain()).toList();
      MessageModel message = MessageModel(
        date: params.message.date,
        sender: replier.personInfo,
        receiver: params.message.receiver,
        likes: [],
        replies: [],
        id: params.message.date,
      );

      if (params.message.imagePath != null) {
        String imageUrl = await _uploadFile(
          filePath: params.message.imagePath!,
          uid: replier.personInfo.uid,
          postDate: params.message.date,
        );
        message = message.copyWith(imageUrl: imageUrl).fromDomain();
      }
      if (params.message.videoPath != null) {
        String videoUrl = await _uploadFile(
          filePath: params.message.videoPath!,
          uid: replier.personInfo.uid,
          postDate: params.message.date,
        );
        message = message.copyWith(videoUrl: videoUrl).fromDomain();
      }
      replies.add(message);
      docRef.update({'replies': replies.map((e) => e.toMap()).toList()});
      firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(params.message.receiver.uid)
          .collection(FirestoreCollections.allChats)
          .doc(replier.personInfo.uid)
          .collection(FirestoreCollections.messages)
          .doc(params.messageId)
          .update({'replies': replies.map((e) => e.toMap()).toList()});
      return messageModel.copyWith(replies: replies).fromDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageModel> sendMessage(SendMessageParams params) async {
    try {
      final sender = await firestoreManager.getPerson(auth.currentUser!.uid);
      MessageModel message = MessageModel(
        date: params.date,
        sender: sender.personInfo,
        receiver: params.receiver,
        likes: [],
        replies: [],
        id: "",
        text: params.text,
      );
      if (params.imagePath != null) {
        String imageUrl = await _uploadFile(
          filePath: params.imagePath!,
          uid: sender.personInfo.uid,
          postDate: params.date,
        );
        message = message.copyWith(imageUrl: imageUrl).fromDomain();
      }
      if (params.videoPath != null) {
        String videoUrl = await _uploadFile(
          filePath: params.videoPath!,
          uid: sender.personInfo.uid,
          postDate: params.date,
        );
        message = message.copyWith(videoUrl: videoUrl).fromDomain();
      }

      // Your Side
      var docRef = firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(sender.personInfo.uid)
          .collection(FirestoreCollections.allChats)
          .doc(params.receiver.uid);

      var chatRef = await docRef.get();
      if (!chatRef.exists) {
        ChatModel chatModel = ChatModel(
          personInfo: params.receiver,
          lastMessage: message,
          chatId: params.receiver.uid,
        );
        docRef.set(chatModel.toMap());
      } else {
        docRef.update({'lastMessage': message.toMap()});
      }
      await docRef
          .collection(FirestoreCollections.messages)
          .add(message.toMap())
          .then((value) {
        message = message.copyWith(id: value.id).fromDomain();
        value.update({'id': value.id});
      });
      // Receiver Side
      docRef = firebaseFirestore
          .collection(FirestoreCollections.chats)
          .doc(params.receiver.uid)
          .collection(FirestoreCollections.allChats)
          .doc(sender.personInfo.uid);
      chatRef = await docRef.get();
      if (!chatRef.exists) {
        ChatModel chatModel = ChatModel(
          personInfo: sender.personInfo,
          lastMessage: message,
          chatId: sender.personInfo.uid,
        );
        docRef.set(chatModel.toMap());
      } else {
        docRef.update({'lastMessage': message.toMap()});
      }
      await docRef
          .collection(FirestoreCollections.messages)
          .doc(message.id)
          .set(message.toMap());

      return message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _uploadFile({
    required String filePath,
    required String uid,
    required String postDate,
  }) async {
    late String fileUrl;
    await storage
        .ref()
        .child('message/$uid/$postDate.jpg')
        .putFile(File(filePath))
        .then(
          (value) async => fileUrl = await value.ref.getDownloadURL(),
        );
    return fileUrl;
  }
}
