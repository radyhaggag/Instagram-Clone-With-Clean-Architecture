import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'story_text.g.dart';

@HiveType(typeId: 2)
class StoryText extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final double fontSize;
  @HiveField(2)
  final String color;
  @HiveField(3)
  final double dx;
  @HiveField(4)
  final double dy;

  StoryText({
    required this.text,
    required this.fontSize,
    required this.color,
    required this.dx,
    required this.dy,
  });

  @override
  List<Object?> get props => [text, fontSize, color, dx, dy];

  StoryText copyWith({
    String? text,
    double? fontSize,
    String? color,
    double? dx,
    double? dy,
  }) {
    return StoryText(
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      color: color ?? this.color,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }
}
