import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'post_media.g.dart';

@HiveType(typeId: 5)
class PostMedia extends HiveObject with EquatableMixin {
  @HiveField(0)
  final List<String> imagesUrl;
  @HiveField(1)
  final List<String> imagesLocalPaths;
  @HiveField(2)
  final List<String> videosUrl;
  @HiveField(3)
  final List<String> videosLocalPaths;

  PostMedia({
    required this.imagesUrl,
    required this.imagesLocalPaths,
    required this.videosUrl,
    required this.videosLocalPaths,
  });

  @override
  List<Object> get props => [
        imagesUrl,
        imagesLocalPaths,
        videosUrl,
        videosLocalPaths,
      ];
}
