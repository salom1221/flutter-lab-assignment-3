import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/screens/album_list_screen.dart';
import 'presentation/screens/album_detail_screen.dart';
import 'data/models/album_model.dart';
import '../../data/models/album_with_photo.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final albumWithPhoto = state.extra as AlbumWithPhoto;
          return AlbumDetailScreen(albumWithPhoto: albumWithPhoto);
        },
      ),
    ],
  );
}
