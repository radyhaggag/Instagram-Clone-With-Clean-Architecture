import 'package:hive/hive.dart';
import '../../features/profile/domain/entities/profile.dart';
import '../../features/shopping/domain/entities/product.dart';

import '../../features/chat/domain/entities/chat.dart';
import '../../features/shopping/domain/entities/shopping_item.dart';
import '../domain/entities/person/person.dart';
import '../domain/entities/post/post.dart';
import '../domain/entities/story/stories.dart';

class AppBoxesName {
  AppBoxesName._();
  static const String postBox = 'postBox';
  static const String personBox = 'personBox';
  static const String storyBox = 'storyBox';
  static const String profileBox = 'profileBox';
  static const String searchBox = 'searchBox';
  static const String shoppingItemsBox = 'shoppingItemsBox';
  static const String productsBox = 'productsBox';
  static const String chatBox = 'chatBox';
}

class AppBoxes {
  AppBoxes._();
  static Box<Post> get postBox => Hive.box<Post>(AppBoxesName.postBox);
  static Box<Person> get personBox => Hive.box<Person>(AppBoxesName.personBox);
  static Box<Stories> get storyBox => Hive.box<Stories>(AppBoxesName.storyBox);
  static Box<Profile> get profileBox => Hive.box<Profile>(
        AppBoxesName.profileBox,
      );
  static Box<Post> get searchBox => Hive.box<Post>(AppBoxesName.searchBox);
  static Box<ShoppingItem> get shoppingItemsBox =>
      Hive.box<ShoppingItem>(AppBoxesName.shoppingItemsBox);
  static Box<Product> get productsBox =>
      Hive.box<Product>(AppBoxesName.productsBox);
  static Box<Chat> get chatBox => Hive.box<Chat>(AppBoxesName.chatBox);
}

class AppBoxesKeys {
  AppBoxesKeys._();
  static const String post = 'post';
  static const String person = 'person';
  static const String story = 'story';
  static const String profile = 'profile';
  static const String search = 'search';
  static const String shoppingItems = 'shoppingItems';
  static const String products = 'products';
  static const String chat = 'chat';
}
