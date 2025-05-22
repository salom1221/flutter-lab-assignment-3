import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../data/models/album_with_photo.dart';
import '../../data/services/http_service.dart';

class AlbumRepository {
  final HttpService service;

  AlbumRepository({HttpService? service}) : service = service ?? HttpService();

  Future<List<AlbumWithPhoto>> getAlbumsWithPhotos() async {
    final albums = await service.getAlbums();
    final photos = await service.getPhotos();

    final Map<int, Photo> albumPhotoMap = {
      for (var photo in photos) photo.albumId: photo
    };

    return albums
        .map((album) => AlbumWithPhoto(album: album, photo: albumPhotoMap[album.id]))
        .toList();
  }
}
