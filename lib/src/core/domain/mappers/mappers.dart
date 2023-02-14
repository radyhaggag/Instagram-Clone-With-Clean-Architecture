import '../../models/person/person_info_model.dart';
import '../../models/person/person_model.dart';
import '../../models/post/comment_model.dart';
import '../../models/post/location_info_model.dart';
import '../../models/post/post_media_model.dart';
import '../../models/post/post_model.dart';
import '../../models/story/story_model.dart';
import '../../models/story/story_text_model.dart';
import '../entities/person/person.dart';
import '../entities/person/person_info.dart';
import '../entities/post/comment.dart';
import '../entities/post/location_info.dart';
import '../entities/post/post.dart';
import '../entities/post/post_media.dart';
import '../entities/story/story.dart';
import '../entities/story/story_text.dart';

extension PersonModelExtension on PersonModel {
  Person toDomain() {
    return Person(
      personInfo: personInfo,
      numOfFollowers: numOfFollowers,
      numOfFollowings: numOfFollowings,
      numOfPosts: numOfPosts,
    );
  }
}

extension PersonExtension on Person {
  PersonModel fromDomain() {
    return PersonModel(
      personInfo: personInfo,
      numOfFollowers: numOfFollowers,
      numOfFollowings: numOfFollowings,
      numOfPosts: numOfPosts,
    );
  }
}

extension StoryModelExtension on StoryModel {
  Story toDomain() => Story(
        publisher: publisher,
        viewers: viewers,
        storyDate: storyDate,
        imageLocalPath: imageLocalPath,
        imageUrl: imageUrl,
        storyText: storyText,
        videoLocalPath: videoLocalPath,
        videoUrl: videoUrl,
        id: id,
      );
}

extension StoryExtension on Story {
  StoryModel fromDomain() => StoryModel(
        publisher: publisher,
        viewers: viewers,
        storyText: storyText,
        imageLocalPath: imageLocalPath,
        imageUrl: imageUrl,
        videoLocalPath: videoLocalPath,
        videoUrl: videoUrl,
        storyDate: storyDate,
        id: id,
      );
}

extension PersonInfoModelExtension on PersonInfoModel {
  PersonInfo toDomain() => PersonInfo(
        name: name,
        imageUrl: imageUrl,
        uid: uid,
        localImagePath: localImagePath,
        username: username,
        bio: bio,
        email: email,
        gender: gender,
        isVerified: isVerified,
      );
}

extension PersonInfoExtension on PersonInfo {
  PersonInfoModel fromDomain() => PersonInfoModel(
        name: name,
        imageUrl: imageUrl,
        uid: uid,
        localImagePath: localImagePath,
        username: username,
        bio: bio,
        email: email,
        gender: gender,
        isVerified: isVerified,
      );
}

extension CommentModelExtension on CommentModel {
  Comment toDomain() => Comment(
        commentText: commentText,
        commenterInfo: commenterInfo,
        likes: likes,
        commentDate: commentDate,
        replies: replies,
        id: id,
      );
}

extension CommentExtension on Comment {
  CommentModel fromDomain() => CommentModel(
        commentText: commentText,
        commenterInfo: commenterInfo,
        likes: likes,
        commentDate: commentDate,
        replies: replies,
        id: id,
      );
}

extension StoryTextModelExtension on StoryTextModel {
  StoryText toDomain() =>
      StoryText(text: text, fontSize: fontSize, color: color, dx: dx, dy: dy);
}

extension StoryTextExtension on StoryText {
  StoryTextModel fromDomain() => StoryTextModel(
      text: text, fontSize: fontSize, color: color, dx: dx, dy: dy);
}

extension PostMediaModelExtension on PostMediaModel {
  PostMedia toDomain() => PostMedia(
        imagesUrl: imagesUrl,
        imagesLocalPaths: imagesLocalPaths,
        videosUrl: videosUrl,
        videosLocalPaths: videosLocalPaths,
      );
}

extension PostMediaExtension on PostMedia {
  PostMediaModel fromDomain() => PostMediaModel(
        imagesUrl: imagesUrl,
        imagesLocalPaths: imagesLocalPaths,
        videosUrl: videosUrl,
        videosLocalPaths: videosLocalPaths,
      );
}

extension PostModelExtension on PostModel {
  Post toDomain() => Post(
        publisher: publisher,
        postMedia: postMedia,
        postText: postText,
        locationInfo: locationInfo,
        postDate: postDate,
        comments: comments,
        likes: likes,
        taggedPeople: taggedPeople,
        id: id,
      );
}

extension PostExtension on Post {
  PostModel fromDomain() => PostModel(
        publisher: publisher,
        postMedia: postMedia,
        postText: postText,
        locationInfo: locationInfo,
        postDate: postDate,
        likes: likes,
        comments: comments,
        taggedPeople: taggedPeople,
        id: id,
      );
}

extension LocationInfoModelExtension on LocationInfoModel {
  LocationInfo toDomain() => LocationInfo(
        lat: lat,
        lng: lng,
        name: name,
      );
}

extension LocationInfoExtension on LocationInfo {
  LocationInfoModel fromDomain() =>
      LocationInfoModel(lat: lat, lng: lng, name: name);
}
