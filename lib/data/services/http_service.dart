import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';
import '../models/photo_model.dart';

class HttpService {
  final baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> getAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Photo>> getPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/photos'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);
      return jsonData.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
