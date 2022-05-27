class MoviesData {
  MoviesData({
    this.results,
  });

  MoviesData.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }

  List<Results>? results;
}

class Results {
  Results({
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
  });

  Results.fromJson(dynamic json) {
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
  }

  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
}
