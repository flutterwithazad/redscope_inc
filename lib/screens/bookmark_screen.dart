import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redscope_inc/screens/unsplash_view_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<String> _bookmarkedImages = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkedImages = prefs.getStringList('bookmarkedImages') ?? [];
    });
  }

  Future<void> _removeBookmark(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkedImages.remove(imageUrl);
      prefs.setStringList('bookmarkedImages', _bookmarkedImages);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bookmark removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Images'),
      ),
      body: _bookmarkedImages.isEmpty
          ? const Center(child: Text('No bookmarks yet'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                crossAxisCount: 2, // Set the desired column count
                itemCount: _bookmarkedImages.length,
                itemBuilder: (context, index) {
                  final imageUrl = _bookmarkedImages[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UnsplashViewPage(imageUrl: imageUrl),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.bookmark,
                                color: Colors.redAccent),
                            onPressed: () => _removeBookmark(imageUrl),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
    );
  }
}
