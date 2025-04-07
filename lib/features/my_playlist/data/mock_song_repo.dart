import 'package:winatchai_music_app/features/my_playlist/domain/entities/song.dart';
import 'package:winatchai_music_app/features/my_playlist/domain/repos/song_repo.dart';

class MockSongRepo implements SongRepo {
  @override
  Future<List<Song>> fetchMyPlaylist() async {
    // mock fetch data delay
    await Future.delayed(const Duration(seconds: 1));
    return mockData;
  }
}

final List<Song> mockData = [
  Song(
    imageUrl:
        'https://res.cloudinary.com/dwumutkiv/image/upload/v1744007550/music_app/jpxvpceusbcgcn9mthsq.jpg',
    name: '幸せのまわり道',
    albumName: 'BIALYSTOCKS',
    mp3Url:
        'https://res.cloudinary.com/dwumutkiv/video/upload/v1744007878/music_app/mpqfbnwd8ilgeiywywkd.mp3',
  ),
  Song(
    imageUrl:
        'https://res.cloudinary.com/dwumutkiv/image/upload/v1744006995/music_app/mpza3r2i4yyomswljvy8.jpg',
    name: 'Need 2',
    albumName: 'Pinegrove',
    mp3Url:
        'https://res.cloudinary.com/dwumutkiv/video/upload/v1744007898/music_app/z61ndlv2twisn9nkz1jp.mp3',
  ),
  Song(
    imageUrl:
        'https://res.cloudinary.com/dwumutkiv/image/upload/v1744006997/music_app/nmslnc2qkyhln5i5r4mc.jpg',
    name: 'Sailor Song',
    albumName: 'Gigi Perez',
    mp3Url:
        'https://res.cloudinary.com/dwumutkiv/video/upload/v1744007889/music_app/fcli6xk9ljeknxqmuupz.mp3',
  ),
  Song(
    imageUrl:
        'https://res.cloudinary.com/dwumutkiv/image/upload/v1744026401/music_app/bhx9hdujq9irmcdocngo.jpg',
    name: 'Oh Klahoma',
    albumName: 'Jack Stauber',
    mp3Url:
        'https://res.cloudinary.com/dwumutkiv/video/upload/v1744007892/music_app/vzkhmcom1hrs7pbmompv.mp3',
  ),
  Song(
    imageUrl:
        'https://res.cloudinary.com/dwumutkiv/image/upload/v1744026215/music_app/s4ukar1mumg6n3esvr3k.jpg',
    name: 'Memories',
    albumName: 'Phil Edwards Band',
    mp3Url:
        'https://res.cloudinary.com/dwumutkiv/video/upload/v1744007898/music_app/p08aityuvk7mzyowauwl.mp3',
  ),
];
