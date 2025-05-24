import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../domain/repositories/album_repository.dart';
import '../blocs/album_bloc.dart';
import '../blocs/album_event.dart';
import '../blocs/album_state.dart';
import 'package:go_router/go_router.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc(AlbumRepository())..add(LoadAlbums()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Albums")),
        body: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlbumLoaded) {
              final albums = state.albums;

              return ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];

                  return ListTile(
                    leading: const Icon(Icons.album),
                    title: Text(album.title),
                    subtitle: Text("Album ID: ${album.id}"),
                    onTap: () => GoRouter.of(context).push('/details', extra: album),
                  );
                },
              );
            } else if (state is AlbumError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

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

                  return GridView.builder(
                    itemCount: photos.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final photo = photos[index];
                      return Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              photo.thumbnailUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "ID: ${photo.id}",
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            photo.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
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
