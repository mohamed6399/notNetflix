import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notrenetflix/models/movie.dart';
import 'package:notrenetflix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final ApiService apiService = ApiService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;
  final List<Movie> _nowPlayingMovieList = [];
  int _nowPlayingMoviePageIndex = 1;
  final List<Movie> _upcomingMovieList = [];
  int _upcomingMoviePageIndex = 1;
  final List<Movie> _animationMoviesList = [];
  int _animationMoviesIndex = 1;
  final List<Movie> serie = [];
  int serieIndex = 1;

  //getter
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlayingMovieList;
  List<Movie> get upcomingMovieList => _upcomingMovieList;
  List<Movie> get animationMoviesList => _animationMoviesList;
  List<Movie> get serieList => serie;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (respponse) {
      print("Error: ${respponse.statusCode}");
      rethrow;
      ;
    }
  }

  Future<void> getnowPlayingMovies() async {
    try {
      List<Movie> movies =
          await apiService.getNowPlaying(pageNumber: _nowPlayingMoviePageIndex);
      _nowPlayingMovieList.addAll(movies);
      _nowPlayingMoviePageIndex++;
      notifyListeners();
    } on Response catch (respponse) {
      print("Error: ${respponse.statusCode}");
      rethrow;
      ;
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies = await apiService.getUpcomingMovies(
          pageNumber: _upcomingMoviePageIndex);
      _upcomingMovieList.addAll(movies);
      _upcomingMoviePageIndex++;
      notifyListeners();
    } on Response catch (respponse) {
      print("Error: ${respponse.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies =
          await apiService.getAnimation(pageNumber: _animationMoviesIndex);
      _animationMoviesList.addAll(movies);
      _animationMoviesIndex++;
      notifyListeners();
    } on Response catch (respponse) {
      print("Error: ${respponse.statusCode}");
      rethrow;
    }
  }

  Future<void> getSerie() async {
    try {
      List<Movie> movies = await apiService.getSerie(pageNumber: serieIndex);
      serie.addAll(movies);
      serieIndex++;
      notifyListeners();
    } on Response catch (respponse) {
      print("Error: ${respponse.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      //on recupere les details du film
      Movie newMovie = await apiService.getDetails(movie: movie);
      //on recupere les videos du film
      newMovie = await apiService.getMovieVideos(movie: newMovie);

      //on recupere le casting
      newMovie = await apiService.getMovieCasting(movie: newMovie);
      //on recupere les images du film
      newMovie = await apiService.getMovieImage(movie: newMovie);

      return newMovie;
    } on Response catch (respponse) {
      print("Error: ${respponse.statusCode}");
      rethrow;
    }
  }

  Future<void> iniData() async {
    await Future.wait(
      [
        getPopularMovies(),
        getnowPlayingMovies(),
        getUpcomingMovies(),
        getAnimationMovies(),
        getSerie(),
      ],
    );
    // notifyListeners();
  }
}
