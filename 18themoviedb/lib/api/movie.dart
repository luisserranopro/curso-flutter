

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.posterPath,
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    required this.title,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate
});

  static Movie fromJson(Map<String, dynamic> json) {
    return Movie(
      popularity: (json['popularity'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      video: json['video'] as bool,
      posterPath: json['poster_path'] as String,
      id: json['id'] as int,
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      genreIds: (json['genre_ids'] as List).map((e) => e as int).toList(),
      title: json['title'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
    );
  }

  String getImage() {
    return "https://image.tmdb.org/t/p/w500/" + this.posterPath;
  }

}