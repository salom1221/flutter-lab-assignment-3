import 'package:dio/dio.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../data/services/api_service.dart';

class AlbumRepository {
  final ApiService apiService;

  AlbumRepository({ApiService? service})
      : apiService = service ?? ApiService(Dio());

  Future<List<Album>> getAlbums() => apiService.getAlbums();
  Future<List<Photo>> getPhotos() => apiService.getPhotos();
}
