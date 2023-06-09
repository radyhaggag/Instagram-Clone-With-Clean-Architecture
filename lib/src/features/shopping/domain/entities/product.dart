import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 11)
class Product extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final String link;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String? capacity;
  @HiveField(5)
  final List<String> aboutThis;
  @HiveField(6)
  final String? stars;

  Product({
    required this.price,
    required this.capacity,
    required this.aboutThis,
    required this.stars,
    required this.title,
    required this.imageUrl,
    required this.link,
  });

  @override
  List<Object?> get props => [
        price,
        capacity,
        aboutThis,
        stars,
        title,
        imageUrl,
        link,
      ];
}
