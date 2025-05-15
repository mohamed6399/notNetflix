// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:notrenetflix/models/person.dart';
import 'package:notrenetflix/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;
  final String? releaseDate;
  final double? vote;
  final List<Person>? casting;
  final List<String>? images;
  //final String? videos;
  final List<String>? videos;
  const Movie({
    required this.id,
    required this.name,
    required this.description,
    this.posterPath,
    this.genres,
    this.releaseDate,
    this.vote,
    this.videos,
    this.casting,
    this.images,
  });

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? posterPath,
    List<String>? genres,
    String? releaseDate,
    double? vote,
    List<String>? videos,
    List<Person>? casting,
    List<String>? images,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      releaseDate: releaseDate ?? this.releaseDate,
      vote: vote ?? this.vote,
      videos: videos ?? this.videos,
      casting: casting ?? this.casting,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': name,
      'description': description,
      'posterPath': posterPath,
      'genres': genres,
      'releaseDate': releaseDate,
      'vote': vote,
    };
  }

  factory Movie.fromjson(Map<String, dynamic> map) {
    return Movie(
      id: (map["id"] ?? 0) as int,
      name: (map["title"] ?? '') as String,
      description: (map["overview"] ?? '') as String,
      posterPath: (map["poster_path"] ?? '') as String,
    );
  }
  String posterURL() {
    API api = API();
    return api.imageUrl + posterPath!;
  }

  String reformatGenres() {
    String categories = "";
    for (int i = 0; i < genres!.length; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        categories += "${genres![i]}, ";
      }
    }
    return categories;
  }
}
