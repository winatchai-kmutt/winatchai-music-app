import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winatchai_music_app/features/my_playlist/presentation/pages/my_playlist_page.dart';

class MusicControlBox extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPause;
  final MusicPlayStatus status;
  final String imageUrl;
  final String musicName;
  final String albumName;
  const MusicControlBox({
    super.key,
    required this.onTap,
    required this.isPause,
    required this.imageUrl,
    required this.musicName,
    required this.albumName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Widget playerBox;
    switch (status) {
      case MusicPlayStatus.loading:
        playerBox = const Padding(
          padding: EdgeInsets.all(16),
          child: CupertinoActivityIndicator(),
        );

      case MusicPlayStatus.error:
        playerBox = const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            CupertinoIcons.exclamationmark_circle,
            size: 36,
            color: Colors.redAccent,
          ),
        );

      case MusicPlayStatus.loaded:
        playerBox = IconButton(
          onPressed: onTap,
          icon: Icon(
            isPause ? CupertinoIcons.play_fill : CupertinoIcons.pause,
            size: 36,
            color: Colors.black,
          ),
        );
    }
    return Row(
      children: [
        // Image Network
        CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder:
              (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image(
                  width: 72,
                  height: 72,
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
          placeholder:
              (context, url) => Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const CupertinoActivityIndicator(),
              ),
          errorWidget:
              (context, url, error) => Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Icon(Icons.error, color: Colors.black54),
                ),
              ),
        ),
        const SizedBox(width: 8),
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              musicName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                height: 1,
              ),
            ),
            Text(
              albumName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1,
              ),
            ),
          ],
        ),
        const Spacer(),

        playerBox,
      ],
    );
  }
}
