import 'package:flutter/material.dart';
import '../../data/models/album_model.dart';

class AlbumDetailScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Album ID: ${album.id}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("Title: ${album.title}"),
      ),
    );
  }
}
