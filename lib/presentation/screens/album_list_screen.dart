import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/album_bloc.dart';
import '../blocs/album_event.dart';
import '../blocs/album_state.dart';
import '../../domain/repositories/album_repository.dart';
import '../../data/models/album_with_photo.dart';
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
                  final albumWithPhoto = albums[index];
                  final album = albumWithPhoto.album;
                  final photo = albumWithPhoto.photo;

                  // Debug print
                  print("Album: ${album.title}, Photo: ${photo?.thumbnailUrl}");

                  return ListTile(
                    leading: photo != null
                        ? Image.network(
                      photo.thumbnailUrl,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                    )
                        : const Icon(Icons.photo),
                    title: Text(album.title),
                    subtitle: Text("Album ID: ${album.id}"),
                    onTap: () => GoRouter.of(context).push('/details', extra: albumWithPhoto),
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
