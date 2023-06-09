import 'package:hive_flutter/hive_flutter.dart';
import '../features/chat/domain/entities/chat.dart';
import '../features/profile/domain/entities/profile.dart';
import '../features/shopping/domain/entities/product.dart';
import '../features/shopping/domain/entities/shopping_item.dart';

import '../core/domain/entities/person/person.dart';
import '../core/domain/entities/person/person_info.dart';
import '../core/domain/entities/post/comment.dart';
import '../core/domain/entities/post/location_info.dart';
import '../core/domain/entities/post/post.dart';
import '../core/domain/entities/post/post_media.dart';
import '../core/domain/entities/story/stories.dart';
import '../core/domain/entities/story/story.dart';
import '../core/domain/entities/story/story_text.dart';
import '../core/utils/app_boxes.dart';

class LocalStorage {
  LocalStorage._();

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(PersonInfoAdapter());
    Hive.registerAdapter(StoryTextAdapter());
    Hive.registerAdapter(StoryAdapter());
    Hive.registerAdapter(StoriesAdapter());
    Hive.registerAdapter(PostMediaAdapter());
    Hive.registerAdapter(PostAdapter());
    Hive.registerAdapter(LocationInfoAdapter());
    Hive.registerAdapter(CommentAdapter());
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(ShoppingItemAdapter());
    Hive.registerAdapter(ChatAdapter());

    await Hive.openBox<Person>(AppBoxesName.personBox);
    await Hive.openBox<Stories>(AppBoxesName.storyBox);
    await Hive.openBox<Post>(AppBoxesName.postBox);
    await Hive.openBox<Profile>(AppBoxesName.profileBox);
    await Hive.openBox<Post>(AppBoxesName.searchBox);
    await Hive.openBox<ShoppingItem>(AppBoxesName.shoppingItemsBox);
    await Hive.openBox<Product>(AppBoxesName.productsBox);
    await Hive.openBox<Chat>(AppBoxesName.chatBox);
  }
}
