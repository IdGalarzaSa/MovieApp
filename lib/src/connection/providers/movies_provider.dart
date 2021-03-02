import 'dart:convert';

import 'package:movies_app/src/connection/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = "649913f37651c80cb709fba8572e0ddb";
  String _url = "api.themoviedb.org";
  String _language = 'es-ES';

  Map<String, String> get basicParams {
    return {
      'api_key': _apikey,
      'language': _language,
    };
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', basicParams);
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final moviesList = new Movies.fromJsonList(decodedData['results']);
    return moviesList.items;
  }
}
