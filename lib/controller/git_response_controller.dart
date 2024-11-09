import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:redscope_inc/modelclass/git_response_model.dart';

Future<List<GistResponse>> fetchGists() async {
  try {
    final response =
        await http.get(Uri.parse('https://api.github.com/gists/public'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData
          .map((itemData) => GistResponse.fromJson(itemData))
          .toList();
    } else {
      throw Exception('Error, status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Catch error on FetchGists $e');
  }
}
