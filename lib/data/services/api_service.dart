import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/album_model.dart';
import '../models/photo_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET("/albums")
  Future<List<Album>> getAlbums();

  @GET("/photos")
  Future<List<Photo>> getPhotos();
}
