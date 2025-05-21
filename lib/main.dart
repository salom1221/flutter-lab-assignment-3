import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(const AlbumApp());
}

class AlbumApp extends StatelessWidget {
  const AlbumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Album List App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.router,
    );
  }
}
