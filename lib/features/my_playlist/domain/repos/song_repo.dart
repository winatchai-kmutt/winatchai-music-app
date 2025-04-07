import 'package:winatchai_music_app/features/my_playlist/domain/entities/song.dart';

abstract class SongRepo {
  // GET MY PLAYLIST
  Future<List<Song>> fetchMyPlaylist();
}
