import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'story.dart';

part 'stories.g.dart';

@HiveType(typeId: 4)
class Stories extends HiveObject with EquatableMixin {
  @HiveField(0)
  final List<Story> stories;

  Stories(this.stories);

  @override
  List<Object?> get props => [stories];
}
