import 'package:shared_preferences/shared_preferences.dart';

class BookmarkManager {
  static Future<void> addBookmark(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];
    if (!bookmarks.contains(imageUrl)) {
      bookmarks.add(imageUrl);
      await prefs.setStringList('bookmarks', bookmarks);
    }
  }

  static Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmarks') ?? [];
  }

  static Future<void> removeBookmark(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];
    bookmarks.remove(imageUrl);
    await prefs.setStringList('bookmarks', bookmarks);
  }
}
