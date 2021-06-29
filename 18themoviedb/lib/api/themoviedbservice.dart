
import 'package:themoviedb/api/movies.dart';
import 'package:themoviedb/api/movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TheMovieDBService {

  static final String API_url = "https://api.themoviedb.org/3";
  static final String API_key = "99b4c3070137e46945a47d68eb4d49f3";

  static Future<List<Movie>> getTopRatedMovies() async {
    var url = API_url + "/movie/top_rated?api_key=" + API_key + "&language=es";
    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final respuestaJSON = json.decode (respuesta.body);
      final peliculasMejorValoradas = Movies.fromJsonList(respuestaJSON['results']);
      return peliculasMejorValoradas;
    }
    return <Movie>[];
  }

}