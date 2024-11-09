import 'dart:convert';
import 'package:redscope_inc/modelclass/git_owner_model.dart';
import 'package:http/http.dart' as http;

Future<GitOwnerModel?> fetchSecondApiData(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return GitOwnerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load second API data: ${response.statusCode}');
    }
  } catch (e) {
    print("Owner Catch error: $e");

    return null;
  }
}
