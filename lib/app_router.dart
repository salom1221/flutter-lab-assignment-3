import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/screens/album_list_screen.dart';
import 'presentation/screens/album_detail_screen.dart';
import 'data/models/album_model.dart';

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
          final album = state.extra as Album;
          return AlbumDetailScreen(album: album);
        },
      ),
    ],
  );
}
