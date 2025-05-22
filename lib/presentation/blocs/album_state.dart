import 'package:equatable/equatable.dart';
import '../../data/models/album_with_photo.dart';

abstract class AlbumState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<AlbumWithPhoto> albums;

  AlbumLoaded(this.albums);

  @override
  List<Object?> get props => [albums];
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError(this.message);

  @override
  List<Object?> get props => [message];
}
