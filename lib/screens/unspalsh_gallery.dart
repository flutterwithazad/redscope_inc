import 'package:flutter/material.dart';
import 'package:redscope_inc/controller/unsplash_controller.dart';
import 'package:redscope_inc/modelclass/unsplash_model.dart';
import 'package:redscope_inc/screens/bookmark_screen.dart';
import 'package:redscope_inc/screens/unsplash_view_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnsplashGallery extends StatefulWidget {
  @override
  _UnsplashGalleryState createState() => _UnsplashGalleryState();
}

class _UnsplashGalleryState extends State<UnsplashGallery> {
  final UnsplashController _unsplashController = UnsplashController();
  late Future<List<UnsplashImage>> _futureImages;
  Set<String> _bookmarkedImages = {};
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchImages();
    _loadBookmarks();
  }

  void _fetchImages() {
    setState(() {
      _futureImages =
          _unsplashController.getImages(_currentPage).then((images) {
        if (images.isEmpty) {
          _unsplashController.refreshCache(_currentPage);
          return _unsplashController.getImages(_currentPage);
        }
        return images;
      });
    });
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkedImages =
          prefs.getStringList('bookmarkedImages')?.toSet() ?? {};
    });
  }

  Future<void> _toggleBookmark(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedBookmarks = Set<String>.from(_bookmarkedImages);

    if (updatedBookmarks.contains(imageUrl)) {
      updatedBookmarks.remove(imageUrl);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bookmark removed'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      updatedBookmarks.add(imageUrl);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image bookmarked!'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    await prefs.setStringList('bookmarkedImages', updatedBookmarks.toList());

    setState(() {
      _bookmarkedImages = updatedBookmarks;
    });
  }

  void _changePage(int newPage) {
    if (newPage < 1) return;
    setState(() {
      _currentPage = newPage;
    });
    _fetchImages();
  }

  void _refreshCache() {
    _unsplashController.refreshCache(_currentPage);
    _fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page $_currentPage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCache,
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UnsplashImage>>(
              future: _futureImages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load images'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No images found'));
                } else {
                  final List<UnsplashImage> images = snapshot.data!;

                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      final bool isBookmarked =
                          _bookmarkedImages.contains(image.imageUrl);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnsplashViewPage(
                                imageUrl: image.imageUrl,
                              ),
                            ),
                          );
                        },
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.black54,
                            trailing: IconButton(
                              icon: Icon(
                                isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.white,
                              ),
                              onPressed: () => _toggleBookmark(image.imageUrl),
                            ),
                          ),
                          child:
                              Image.network(image.imageUrl, fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _currentPage > 1
                    ? () => _changePage(_currentPage - 1)
                    : null,
                child: const Text("Previous"),
              ),
              ElevatedButton(
                onPressed: () => _changePage(_currentPage + 1),
                child: const Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
