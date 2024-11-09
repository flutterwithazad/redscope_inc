import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redscope_inc/helper/unsplash_cache_helper.dart';
import 'package:redscope_inc/modelclass/unsplash_model.dart';

class UnsplashController {
  static const String _cacheKey = 'unsplashImagesCache';
  static const String _apiBaseUrl = 'https://api.unsplash.com/photos';
  static const String _clientId = '0fqVNIbvsmIP_YOHaXABEzVDI6Ij-S0vA9dYey-dl3Q';

  Future<List<UnsplashImage>> getImages(int page) async {
    final String apiUrl =
        '$_apiBaseUrl?client_id=$_clientId&page=$page&per_page=20';

    final String cacheKeyWithPage = '$_cacheKey-page-$page';
    bool isCached = await CacheHelper.isDataCached(cacheKeyWithPage);

    if (isCached) {
      String? cachedData = await CacheHelper.getData(cacheKeyWithPage);
      if (cachedData != null) {
        List<dynamic> jsonResponse = jsonDecode(cachedData);
        return jsonResponse
            .map((data) => UnsplashImage.fromJson(data))
            .toList();
      }
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<UnsplashImage> images =
          jsonResponse.map((data) => UnsplashImage.fromJson(data)).toList();

      CacheHelper.saveData(cacheKeyWithPage, jsonEncode(jsonResponse));

      return images;
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<void> refreshCache(int page) async {
    final String apiUrl =
        '$_apiBaseUrl?client_id=$_clientId&page=$page&per_page=30';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      final String cacheKeyWithPage = '$_cacheKey-page-$page';

      CacheHelper.saveData(cacheKeyWithPage, jsonEncode(jsonResponse));
    } else {
      throw Exception('Failed to refresh cache');
    }
  }
}
