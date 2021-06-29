

import 'package:themoviedb/api/movie.dart';

class Movies {

  Movies();

  static List<Movie> fromJsonList(List<dynamic> jsonList) {
    List<Movie> listaPeliculas = [];
    if (jsonList != null) {
      for (var pelicula in jsonList) {
        final movie = Movie.fromJson(pelicula);
        listaPeliculas.add(movie);
      }
    }
    return listaPeliculas;
  }
}