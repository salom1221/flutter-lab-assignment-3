import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../data/services/http_service.dart';

class AlbumRepository {
  final HttpService service;

  AlbumRepository({HttpService? service}) : service = service ?? HttpService();

  Future<List<Album>> getAlbums() async => await service.getAlbums();

  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    final allPhotos = await service.getPhotos();
    return allPhotos.where((photo) => photo.albumId == albumId).toList();
  }
}
