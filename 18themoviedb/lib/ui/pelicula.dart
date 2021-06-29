
import 'package:flutter/material.dart';
import 'package:themoviedb/api/movie.dart';

class Pelicula extends StatelessWidget {

  Movie movie;

  Pelicula({required this.movie}): super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.movie.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Image.network(this.movie.getImage()),
          Text(this.movie.overview)
        ],
      )
    );
  }


}