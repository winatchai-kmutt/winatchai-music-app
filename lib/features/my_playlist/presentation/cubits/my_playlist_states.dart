import 'package:winatchai_music_app/features/my_playlist/domain/entities/song.dart';

abstract class MyPlaylistState {}

// Initial
class MyPlaylistInitial extends MyPlaylistState {}

// Initial
class MyPlaylistLoading extends MyPlaylistState {}

// Initial
class MyPlaylistLoaded extends MyPlaylistState {
  final List<Song> songs;
  MyPlaylistLoaded({required this.songs});
}

// Initial
class MyPlaylistError extends MyPlaylistState {
  final String message;

  MyPlaylistError({required this.message});
}
