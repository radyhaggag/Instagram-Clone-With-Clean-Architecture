import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens_args.dart';
import '../core/domain/entities/person/person_info.dart';
import '../core/domain/entities/post/post.dart';
import '../features/chat/presentation/bloc/chat_bloc.dart';
import '../features/chat/presentation/screens/chat_with_screen.dart';
import '../features/chat/presentation/screens/chats_screen.dart';
import '../features/post/presentation/screens/edit_post_screen.dart';
import '../features/post/presentation/screens/view_replies_screen.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/view_persons_screen.dart';
import '../features/reels/domain/entities/reel.dart';
import '../features/reels/presentation/bloc/reels_bloc.dart';
import '../features/reels/presentation/screens/view_reel_screen.dart';
import '../features/post/presentation/screens/add_location_screen.dart';
import '../features/post/presentation/screens/view_post_comments_screen.dart';

import '../core/domain/entities/person/person.dart';
import '../core/utils/app_enums.dart';
import '../core/utils/app_strings.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/post/presentation/bloc/post_bloc.dart';
import '../features/post/presentation/screens/add_post_screen.dart';
import '../features/post/presentation/screens/tag_people_screen.dart';
import '../features/post/presentation/screens/view_post_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/reels/presentation/screens/add_reel_screen.dart';
import '../features/reels/presentation/screens/view_reels_comments_screen.dart';
import '../features/shopping/presentation/bloc/shopping_bloc.dart';
import '../features/shopping/presentation/screens/product_details_screen.dart';
import '../features/splash/presentation/bloc/splash_bloc.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/splash/presentation/screens/welcome_screen.dart';
import '../features/story/presentation/bloc/story_bloc.dart';
import '../features/story/presentation/screens/story_screen.dart';
import '../features/story/presentation/screens/view_stories.dart';
import 'container_injector.dart';

class Routes {
  Routes._();

  static const String addLocation = "/addLocation";
  static const String addPost = "/addPost";
  static const String addReel = "/addReel";
  static const String addStory = "/addStory";
  static const String chatWithScreen = "/chatWithScreen";
  static const String chatsScreen = "/chatsScreen";
  static const String editPost = "/editPost";
  static const String editProfile = "/editProfile";
  static const String home = "/home";
  static const String login = "/login";
  static const String profileScreen = "/profileScreen";
  static const String resetPassword = "/resetPassword";
  static const String signUp = "/signUp";
  static const String splash = "/splash";
  static const String tagsPeople = "/tagsPeople";
  static const String viewLikers = "/viewLikers";
  static const String viewPersons = "/viewPersons";
  static const String viewPost = "/viewPost";
  static const String viewPostComments = "/viewPostComments";
  static const String viewProductDetails = "/viewProductDetails";
  static const String viewReel = "/viewReel";
  static const String viewReelComments = "/viewReelComments";
  static const String viewReplies = "/viewReplies";
  static const String viewStories = "/viewStories";
  static const String welcome = "/welcome";
}

class AppRouter {
  AppRouter._();

  static final _authBloc = sl<AuthBloc>();
  static final _postBloc = sl<PostBloc>();
  static final _storyBloc = sl<StoryBloc>();

  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SplashBloc>(),
            child: const SplashScreen(),
          ),
        );

      case Routes.welcome:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>(
            create: (context) => _authBloc,
            child: const WelcomeScreen(),
          ),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>.value(
            value: _authBloc,
            child: const LoginScreen(),
          ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>.value(
            value: _authBloc,
            child: const SignupScreen(),
          ),
        );

      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthBloc>.value(
            value: _authBloc,
            child: const ResetPasswordScreen(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<HomeBloc>()
                  ..add(HomeLoadStories())
                  ..add(HomeLoadPosts()),
              ),
              BlocProvider(create: (context) => sl<PostBloc>()),
              BlocProvider(create: (context) => sl<StoryBloc>()),
            ],
            child: HomeScreen(person: settings.arguments as Person),
          ),
        );

      case Routes.addStory:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<StoryBloc>.value(
            value: _storyBloc,
            child: const StoryScreen(),
          ),
        );
      case Routes.viewStories:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<StoryBloc>.value(
            value: _storyBloc,
            child: ViewStories(
                screenArgs: settings.arguments as ViewStoriesScreenArgs),
          ),
        );
      case Routes.addPost:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: AddPostScreen(mediaType: settings.arguments as MediaType),
          ),
        );
      case Routes.tagsPeople:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: const TagPeopleScreen(),
          ),
        );
      case Routes.addLocation:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: const AddLocationScreen(),
          ),
        );
      case Routes.viewPostComments:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: ViewPostCommentsScreen(
                screenArgs: settings.arguments as PostScreensArgs),
          ),
        );
      case Routes.viewReplies:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: ViewRepliesScreen(
              screenArgs: settings.arguments as PostScreensArgs,
            ),
          ),
        );
      case Routes.viewPost:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: ViewPostScreen(
              screensArgs: settings.arguments as PostScreensArgs,
            ),
          ),
        );
      case Routes.editPost:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PostBloc>.value(
            value: _postBloc,
            child: EditPostScreen(
              post: settings.arguments as Post,
            ),
          ),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            personInfo: settings.arguments as PersonInfo,
          ),
        );
      case Routes.viewPersons:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProfileBloc>(
            create: (context) => sl<ProfileBloc>(),
            child: ViewPersonsScreen(
              screenArgs: settings.arguments as PersonsScreenArgs,
            ),
          ),
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProfileBloc>(
            create: (context) => sl<ProfileBloc>(),
            child: EditProfileScreen(
              person: settings.arguments as Person,
            ),
          ),
        );
      case Routes.viewReelComments:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ReelsBloc>(
            create: (context) => sl<ReelsBloc>(),
            child: ViewReelsCommentsScreen(
                screenArgs: settings.arguments as ReelsScreensArgs),
          ),
        );
      case Routes.addReel:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ReelsBloc>(
            create: (context) => sl<ReelsBloc>(),
            child: const AddReelScreen(),
          ),
        );
      case Routes.viewReel:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ReelsBloc>(
            create: (context) => sl<ReelsBloc>(),
            child: ViewReelScreen(reel: settings.arguments as Reel),
          ),
        );
      case Routes.viewProductDetails:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ShoppingBloc>(
            create: (context) => sl<ShoppingBloc>()
              ..add(GetProduct(
                settings.arguments as String,
              )),
            child: ProductDetailsScreen(
              productLink: settings.arguments as String,
            ),
          ),
        );
      case Routes.chatsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChatBloc>(
            create: (context) => sl<ChatBloc>()..add(GetChats()),
            child: const ChatsScreen(),
          ),
        );
      case Routes.chatWithScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChatBloc>(
            create: (context) => sl<ChatBloc>()
              ..add(GetMessages((settings.arguments as PersonInfo).uid)),
            child: ChatWithScreen(personInfo: settings.arguments as PersonInfo),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
    }
  }
}

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.noRoute)),
    );
  }
}
