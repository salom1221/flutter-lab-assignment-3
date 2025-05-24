import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/album_with_photo.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../../domain/repositories/album_repository.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc(this.repository) : super(AlbumInitial()) {
    on<LoadAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.getAlbums();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError("Failed to load albums: $e"));
      }
    });
  }
}
