import 'package:dio/dio.dart';
import 'package:notrenetflix/models/movie.dart';
import 'package:notrenetflix/models/person.dart';
import 'package:notrenetflix/services/api.dart';

class ApiService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String url = api.baseUrl + path;
    // on contruit les parametres de la requete
    // ces parametre seront present dans chaques requetes

    Map<String, dynamic> query = {
      'api_key': api.apikey,
      'language': 'fr-FR',
    };
    // on verifie si params n'est pas null
    if (params != null) {
      query.addAll(params);
    }
    //on fais l'appel a l'api
    final response = await dio.get(url, queryParameters: query);
    //on check si la requet s'est bien passé
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('movie/popular', params: {
      'page': pageNumber,
    });
    //on check si la requet s'est bien passé
    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromjson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('movie/now_playing', params: {
      'page': pageNumber,
    });
    //on check si la requet s'est bien passé
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromjson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response = await getData('movie/upcoming', params: {
      'page': pageNumber,
    });
    //on check si la requet s'est bien passé
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromjson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimation({required int pageNumber}) async {
    Response response = await getData('discover/movie', params: {
      'page': pageNumber,
      'with_genres': 16,
    });
    //on check si la requet s'est bien passé
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromjson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getSerie({required int pageNumber}) async {
    Response response = await getData('discover/movie', params: {
      'page': pageNumber,
      'with_genres': 18,
    });
    //on check si la requet s'est bien passé
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromjson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getDetails({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}', params: {});
    //on check si la requet s'est bien passé
    if (response.statusCode == 200) {
      Map _data = response.data;
      var genres = _data['genres'] as List;
      List<String> genresList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newMovie = movie.copyWith(
        genres: genresList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average'],
      );
      return newMovie;
    } else {
      throw response;
    }
  }

  // Future<Movie> getMovieVideos({required Movie movie}) async {
  //   Response response = await getData('movie/${movie.id}/videos');

  //   if (response.statusCode == 200) {
  //     Map data = response.data;
  //     List<String> videoskeys =
  //         data['results'].map<String>((dynamic videoJson) {
  //       return videoJson['key'] as String;
  //     }).toList();
  //     return movie.copyWith(videos: videoskeys);
  //   } else {
  //     throw response;
  //   }
  // }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}/videos');

    if (response.statusCode == 200) {
      Map data = response.data;

      // Vérifie que "results" est une liste
      if (data['results'] is List) {
        List results = data['results'];

        // Si la liste est vide, on retourne un Movie avec une liste vide
        if (results.isEmpty) {
          return movie.copyWith(videos: []);
        }

        // Sinon, on extrait les clés
        List<String> videosKeys = results
            .where((videoJson) => videoJson['key'] != null)
            .map<String>((videoJson) => videoJson['key'] as String)
            .toList();

        return movie.copyWith(videos: videosKeys);
      } else {
        // Si les résultats ne sont pas une liste
        return movie.copyWith(videos: []);
      }
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCasting({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Person> casting = data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();
      return movie.copyWith(casting: casting);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieImage({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}/images', params: {
      'include_image_language': "null",
    });
    if (response.statusCode == 200) {
      Map data = response.data;

      List<String> imagePath =
          data['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();
      return movie.copyWith(images: imagePath);
    } else {
      throw response;
    }
  }
}
