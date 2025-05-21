import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/album_bloc.dart';
import '../blocs/album_event.dart';
import '../blocs/album_state.dart';
import '../../domain/repositories/album_repository.dart';
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
              return ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];
                  return ListTile(
                    title: Text(album.title),
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
