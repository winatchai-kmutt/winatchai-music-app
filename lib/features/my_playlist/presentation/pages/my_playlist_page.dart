import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:winatchai_music_app/features/common/components/custom_scaffold.dart';
import 'package:winatchai_music_app/features/my_playlist/domain/entities/song.dart';

import 'package:winatchai_music_app/features/my_playlist/presentation/components/music_control_box.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/components/music_list_tile.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/components/music_slider.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/cubits/my_playlist_cubit.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/cubits/my_playlist_states.dart';

class MyPlaylistPage extends StatefulWidget {
  const MyPlaylistPage({super.key});

  @override
  State<MyPlaylistPage> createState() => _MyPlaylistPageState();
}

class _MyPlaylistPageState extends State<MyPlaylistPage> {
  late MyPlaylistController controller;
  @override
  void initState() {
    super.initState();
    controller = MyPlaylistController();

    context.read<MyPlaylistCubit>().getMyPlaylistSongs();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "My Playlist",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<MyPlaylistCubit, MyPlaylistState>(
                builder: (context, state) {
                  if (state is MyPlaylistLoaded) {
                    // Initial controller
                    controller.initialize(songs: state.songs);
                    return Column(
                      children: [
                        // musics
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: ListView.separated(
                              itemCount: state.songs.length,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return ValueListenableBuilder(
                                  valueListenable: controller,
                                  builder: (context, value, _) {
                                    final song = state.songs[index];
                                    final isPlaying =
                                        index ==
                                        value.songIndexSelected;
                                    return MusicListTile(
                                      onPlayTap: () {
                                        controller.onSelectedMusic(
                                          index,
                                        );
                                      },
                                      isPlaying: isPlaying,
                                      imageUrl: song.imageUrl,
                                      musicName: song.name,
                                      albumName: song.albumName,
                                    );
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 16),
                            ),
                          ),
                        ),

                        // music control
                        ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, value, _) {
                            final index = value.songIndexSelected!;
                            return Column(
                              children: [
                                MusicSlider(
                                  onChangeStart: (_) {
                                    controller.onSeekStart();
                                  },
                                  onChangeEnd: controller.onSeekEnd,
                                  onSlided: controller.onSliding,
                                  slideProgress: value.slideProgress,
                                  isUserSeeking: value.isUserSeeking,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Visibility(
                                    visible:
                                        value.songIndexSelected !=
                                        null,
                                    child: MusicControlBox(
                                      onTap: controller.onPlayTap,
                                      isPause: value.isPause,
                                      status: value.status,
                                      imageUrl:
                                          value.songs[index].imageUrl,
                                      musicName:
                                          value.songs[index].name,
                                      albumName:
                                          value
                                              .songs[index]
                                              .albumName,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }

                  if (state is MyPlaylistError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    );
                  }

                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MusicPlayStatus { loading, loaded, error }

class MyPlaylistValue {
  final List<Song> songs;
  final double slideProgress;
  final bool isPause;
  final bool isUserSeeking;
  final int? songIndexSelected;
  final MusicPlayStatus status;

  MyPlaylistValue({
    required this.songs,
    required this.slideProgress,
    required this.isPause,
    required this.isUserSeeking,
    this.songIndexSelected,
    this.status = MusicPlayStatus.loading,
  });

  MyPlaylistValue copyWith({
    List<Song>? songs,
    int? songIndexSelected,
    double? slideProgress,
    bool? isPause,
    bool? isUserSeeking,
    MusicPlayStatus? status,
  }) {
    return MyPlaylistValue(
      songs: songs ?? this.songs,
      songIndexSelected: songIndexSelected ?? this.songIndexSelected,
      slideProgress: slideProgress ?? this.slideProgress,
      isPause: isPause ?? this.isPause,
      isUserSeeking: isUserSeeking ?? this.isUserSeeking,
      status: status ?? this.status,
    );
  }
}

class MyPlaylistController extends ValueNotifier<MyPlaylistValue> {
  MyPlaylistController()
    : super(
        MyPlaylistValue(
          songs: [],
          // Initial fist song with index 0
          songIndexSelected: 0,
          slideProgress: 0.0,
          isPause: true,
          isUserSeeking: false,
        ),
      );

  late AudioPlayer player;

  void initialize({required List<Song> songs}) {
    player = AudioPlayer();

    value = value.copyWith(songs: songs);

    if (songs.isNotEmpty) {
      onSelectedMusic(value.songIndexSelected!, autoPlay: false);
    }

    // Update status
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        value = value.copyWith(status: MusicPlayStatus.loading);
        _nextSong();
      }
      if (state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.idle) {
        value = value.copyWith(status: MusicPlayStatus.loading);
      }

      if (state.processingState == ProcessingState.ready) {
        value = value.copyWith(status: MusicPlayStatus.loaded);
      }
    });

    // Update song progress currentDuration music
    player.positionStream.listen((currentDuration) {
      // Wait until seeking is complete to avoid lag
      if (!value.isUserSeeking && player.duration != null) {
        _updateProgress(currentDuration, player.duration!);
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void onSelectedMusic(int songIndex, {bool autoPlay = true}) async {
    // Every start new song -> restore to default
    _restoreSlider();

    // Reset to default state if music done
    player.pause();
    player.seek(Duration.zero);
    value = value.copyWith(slideProgress: 0.0, isUserSeeking: false);

    try {
      await player.setUrl(value.songs[songIndex].mp3Url);
    } catch (e) {
      value = value.copyWith(status: MusicPlayStatus.error);
    }

    value = value.copyWith(
      songIndexSelected: songIndex,
      isPause: !autoPlay,
    );
    if (autoPlay) {
      player.play();
    }
  }

  void onSliding(double slideProgress) {
    value = value.copyWith(slideProgress: slideProgress);
  }

  void onPlayTap() async {
    value = value.copyWith(isPause: !value.isPause);
    value.isPause ? player.pause() : player.play();
  }

  void onSeekStart() {
    value = value.copyWith(isUserSeeking: true);
  }

  void onSeekEnd(double slideProgress) {
    final allDuration = player.duration;
    if (allDuration == null) {
      return;
    }
    // handler if Seek to end
    if (slideProgress == 100) {
      _nextSong();
      return;
    }

    // 0.0 - 100.0 -> percent, targetDuration with percentage
    final targetDuration = allDuration * (slideProgress / 100);
    player.seek(targetDuration);
    value = value.copyWith(isUserSeeking: false);
  }

  void _updateProgress(
    Duration currentDuration,
    Duration? allDuration,
  ) {
    if (allDuration == null || allDuration.inMilliseconds < 0) {
      return;
    }
    final nowProgress =
        (currentDuration.inMilliseconds /
            allDuration.inMilliseconds) *
        100;
    if (nowProgress.isInfinite) {
      return;
    }
    value = value.copyWith(slideProgress: nowProgress.clamp(0, 100));
  }

  void _nextSong() {
    // on end, run next song
    int nextSongIndex = value.songIndexSelected! + 1;
    if (nextSongIndex > (value.songs.length - 1)) {
      // back to fist song
      nextSongIndex = 0;
    }
    onSelectedMusic(nextSongIndex);
  }

  void _restoreSlider() {
    // Reset to default state if music done
    player.pause();
    player.seek(Duration.zero);
    value = value.copyWith(slideProgress: 0.0, isUserSeeking: false);
  }
}
