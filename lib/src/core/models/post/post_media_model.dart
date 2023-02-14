import '../../domain/entities/post/post_media.dart';

class PostMediaModel extends PostMedia {
  PostMediaModel({
    required super.imagesUrl,
    required super.imagesLocalPaths,
    required super.videosUrl,
    required super.videosLocalPaths,
  });

  factory PostMediaModel.fromMap(Map<String, dynamic> map) {
    return PostMediaModel(
      imagesUrl: List.from(map['imagesUrl'].map((image) => image).toList()),
      imagesLocalPaths:
          List.from(map['imagesLocalPaths'].map((image) => image).toList()),
      videosUrl: List.from(
        map['videosUrl'].map((video) => video).toList(),
      ),
      videosLocalPaths: List.from(
        map['videosLocalPaths'].map((video) => video).toList(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imagesUrl': imagesUrl,
      'imagesLocalPaths': imagesLocalPaths,
      'videosUrl': videosUrl,
      'videosLocalPaths': videosLocalPaths,
    };
  }
}
