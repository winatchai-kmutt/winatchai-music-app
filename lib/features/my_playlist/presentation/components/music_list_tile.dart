import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicListTile extends StatelessWidget {
  final String imageUrl;
  final String musicName;
  final String albumName;
  final bool isPlaying;
  final VoidCallback onPlayTap;

  const MusicListTile({
    super.key,
    required this.imageUrl,
    required this.musicName,
    required this.albumName,
    required this.onPlayTap,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
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
        IconButton(
          onPressed: onPlayTap,
          icon: Icon(
            CupertinoIcons.play_circle,
            size: 36,
            color: isPlaying ? Colors.black : Colors.black54,
          ),
        ),
      ],
    );
  }
}
