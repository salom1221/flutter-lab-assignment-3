import 'package:flutter/material.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../domain/repositories/album_repository.dart';

class AlbumDetailScreen extends StatefulWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late Future<List<Photo>> _photos;

  @override
  void initState() {
    super.initState();
    _photos = AlbumRepository().getPhotosByAlbumId(widget.album.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Album ID: ${widget.album.id}")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.album.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Photo>>(
                future: _photos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No photos found.'));
                  }

                  final photos = snapshot.data!;
                  return ListView.builder(
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      final photo = photos[index];
                      return ListTile(
                        leading: Image.network(
                          photo.thumbnailUrl,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                        ),
                        title: Text(photo.title),
                        subtitle: Text("Photo ID: ${photo.id}"),
                      );
                    },
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
