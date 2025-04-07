import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:winatchai_music_app/features/common/components/custom_scaffold.dart';
import 'package:winatchai_music_app/features/my_playlist/my_playlist_route.dart';

final goRouter = GoRouter(
  initialLocation: "/my-playlist",
  // ONLY /my-playlist
  redirect: (context, state) {
    return "/my-playlist";
  },
  errorBuilder:
      (context, state) => const CustomScaffold(
        body: Center(child: Text("Page not found!")),
      ),
  routes: [MyPlaylistRoute(path: "/my-playlist").route],
);
