import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winatchai_music_app/config/app_router.dart';
import 'package:winatchai_music_app/features/my_playlist/data/mock_song_repo.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/cubits/my_playlist_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initial services
    final songRepo = MockSongRepo();

    return MultiBlocProvider(
      providers: [
        BlocProvider<MyPlaylistCubit>(
          create: (context) => MyPlaylistCubit(songRepo: songRepo),
        ),
      ],
      child: MaterialApp.router(
        title: "Winat music app",
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
