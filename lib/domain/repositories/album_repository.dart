import 'package:dio/dio.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../data/models/album_with_photo.dart';
import '../../data/services/api_service.dart';

class AlbumRepository {
  final ApiService apiService;

  AlbumRepository({ApiService? service})
      : apiService = service ?? ApiService(Dio());

  Future<List<AlbumWithPhoto>> getAlbumsWithPhotos() async {
    final albums = await apiService.getAlbums();
    final photos = await apiService.getPhotos();

    // Map albumId -> first matching photo
    final Map<int, Photo> albumPhotoMap = {
      for (var photo in photos) photo.albumId: photo
    };

    return albums
        .map((album) => AlbumWithPhoto(album: album, photo: albumPhotoMap[album.id]))
        .toList();
  }
}
