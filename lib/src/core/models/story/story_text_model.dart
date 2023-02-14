import '../../domain/entities/story/story_text.dart';

class StoryTextModel extends StoryText {
  StoryTextModel({
    required super.text,
    required super.fontSize,
    required super.color,
    required super.dx,
    required super.dy,
  });

  factory StoryTextModel.fromMap(Map<String, dynamic> map) {
    return StoryTextModel(
      text: map['text'],
      fontSize: map['fontSize'],
      color: map['color'],
      dx: map['dx'],
      dy: map['dy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'fontSize': fontSize,
      'color': color,
      'dx': dx,
      'dy': dy,
    };
  }
}
