import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getDeveloperToken() async {
  final response = await http.get(Uri.parse(
      'https://us-central1-music-app-9ee48.cloudfunctions.net/getDeveloperToken'));

  if (response.statusCode == 200) {
    // Parse the JSON response
    final json = jsonDecode(response.body);
    final token = json['token'];
    return token;
  } else {
    // Handle errors
    throw Exception('Failed to load developer token');
  }
}
