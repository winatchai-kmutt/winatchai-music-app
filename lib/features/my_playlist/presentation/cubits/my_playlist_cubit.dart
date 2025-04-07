import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winatchai_music_app/features/my_playlist/domain/repos/song_repo.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/cubits/my_playlist_states.dart';

class MyPlaylistCubit extends Cubit<MyPlaylistState> {
  final SongRepo songRepo;
  MyPlaylistCubit({required this.songRepo})
    : super(MyPlaylistInitial());

  Future<void> getMyPlaylistSongs() async {
    try {
      emit(MyPlaylistLoading());
      final songs = await songRepo.fetchMyPlaylist();
      emit(MyPlaylistLoaded(songs: songs));
    } catch (e) {
      emit(MyPlaylistError(message: "Have somthing wrong... \n$e"));
    }
  }
}
