import 'package:flutter/material.dart';
import 'package:notrenetflix/constance.dart';
import 'package:notrenetflix/repositories/data_repository.dart';
import 'package:notrenetflix/ui/widgets/movie_card.dart';
import 'package:notrenetflix/ui/widgets/movie_category.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  void _getMovies() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset(
          'assets/images/netflix_logo_2.png',
          fit: BoxFit.cover,
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 500,
            color: Colors.red,
            child: dataProvider.popularMovieList.isNotEmpty
                ? MovieCard(movie: dataProvider.popularMovieList[0])
                : const Center(),
          ),
          MovieCategory(
              label: "Tendance actuelle",
              moviList: dataProvider.popularMovieList,
              imageHeight: 160,
              imageWidth: 110,
              callback: () {
                dataProvider.getPopularMovies();
              }),
          SizedBox(
            height: 15,
          ),
          MovieCategory(
              label: "Actuellement au cinema",
              moviList: dataProvider.nowPlaying,
              imageHeight: 320,
              imageWidth: 220,
              callback: () {
                dataProvider.getnowPlayingMovies();
              }),
          SizedBox(
            height: 15,
          ),
          MovieCategory(
              label: "Ils arrivent bientot",
              moviList: dataProvider.upcomingMovieList,
              imageHeight: 160,
              imageWidth: 110,
              callback: () {
                dataProvider.getUpcomingMovies();
              }),
          const SizedBox(
            height: 5,
          ),
          MovieCategory(
              label: "Films d'animation",
              moviList: dataProvider.animationMoviesList,
              imageHeight: 320,
              imageWidth: 220,
              callback: () {
                dataProvider.getAnimationMovies();
              }),
          const SizedBox(
            height: 5,
          ),
          MovieCategory(
              label: "serie",
              moviList: dataProvider.animationMoviesList,
              imageHeight: 160,
              imageWidth: 110,
              callback: () {
                dataProvider.getAnimationMovies();
              }),
        ],
      ),
    );
  }
}
