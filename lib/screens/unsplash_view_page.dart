import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:redscope_inc/helper/bookmark_manager.dart';

class UnsplashViewPage extends StatefulWidget {
  final String imageUrl;

  UnsplashViewPage({required this.imageUrl});

  @override
  _UnsplashViewPageState createState() => _UnsplashViewPageState();
}

class _UnsplashViewPageState extends State<UnsplashViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoom In/Out'),
        backgroundColor: Colors.black,
      ),
      body: PhotoViewGallery.builder(
        itemCount: 1,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(),
      ),
    );
  }
}
