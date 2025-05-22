import 'package:flutter/material.dart';
import '../../data/models/album_with_photo.dart';

class AlbumDetailScreen extends StatelessWidget {
  final AlbumWithPhoto albumWithPhoto;

  const AlbumDetailScreen({super.key, required this.albumWithPhoto});

  @override
  Widget build(BuildContext context) {
    final album = albumWithPhoto.album;
    final photo = albumWithPhoto.photo;

    return Scaffold(
      appBar: AppBar(title: Text("Album ID: ${album.id}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the full-size photo
            if (photo != null)
              Image.network(
                photo.url,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100),
              )
            else
              const Icon(Icons.image_not_supported, size: 100),

            const SizedBox(height: 20),

            // Display the album title
            Text(
              "Album Title:\n${album.title}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Display the album ID
            Text("Album ID: ${album.id}"),

            // Display the photo ID
            if (photo != null) Text("Photo ID: ${photo.id}"),

            // Display the photo title
            if (photo != null)
              Text(
                "Photo Title:\n${photo.title}",
                style: const TextStyle(fontSize: 16),
              ),

            // Display thumbnail URL (optional)
            if (photo != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Thumbnail URL:\n${photo.thumbnailUrl}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
