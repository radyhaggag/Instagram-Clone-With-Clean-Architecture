import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'shopping_item.g.dart';

@HiveType(typeId: 10)
class ShoppingItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final String link;

  ShoppingItem({
    required this.title,
    required this.imageUrl,
    required this.link,
  });

  @override
  List<Object> get props => [title, imageUrl, link];
}
