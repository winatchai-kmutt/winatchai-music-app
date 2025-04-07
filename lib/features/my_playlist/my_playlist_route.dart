import 'package:go_router/go_router.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/pages/my_playlist_page.dart';

class MyPlaylistRoute {
  final String path;

  MyPlaylistRoute({required this.path});

  GoRoute get route =>
      GoRoute(path: path, builder: (context, state) => const MyPlaylistPage());
}
