import 'album_model.dart';
import 'photo_model.dart';

class AlbumWithPhoto {
  final Album album;
  final Photo? photo;

  AlbumWithPhoto({required this.album, this.photo});
}
