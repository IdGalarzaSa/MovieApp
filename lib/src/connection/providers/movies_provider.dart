import 'dart:async';
import 'dart:convert';

import 'package:movies_app/src/connection/models/cast_model.dart';
import 'package:movies_app/src/connection/models/movies_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = "649913f37651c80cb709fba8572e0ddb";
  String _url = "api.themoviedb.org";
  String _language = 'es-ES';
  int _popularMoviesPage = 0;

  // Keep all movies list into this list
  List<Movie> popularMoviesList = [];
  var _isLoading = false;

  // Stream
  StreamController<List<Movie>> _popularsStreamController =
      new StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink =>
      _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularMoviesStream =>
      _popularsStreamController.stream;

  dispose() {
    _popularsStreamController.close();
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    return await makeRequest(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    if (_isLoading) return [];

    _isLoading = true;

    _popularMoviesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularMoviesPage.toString()
    });
    List<Movie> moviesList = await makeRequest(url);
    popularMoviesList.addAll(moviesList);
    popularMoviesSink(popularMoviesList);
    _isLoading = false;
    return moviesList;
  }

  Future<List<Cast>> getCast(Movie movie) async {
    final url = Uri.https(_url, '3/movie/${movie.id}/credits', {
      'api_key': _apikey,
      'language': _language,
    });
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final castList =
        new CastResponse.fromJsonList(decodedData['cast']).castList;
    return castList;
  }

  Future<List<Movie>> makeRequest(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final moviesList = new Movies.fromJsonList(decodedData['results']).items;
    return moviesList;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });
    return await makeRequest(url);
  }
}
