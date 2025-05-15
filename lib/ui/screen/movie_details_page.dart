import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notrenetflix/constance.dart';
import 'package:notrenetflix/models/movie.dart';
import 'package:notrenetflix/repositories/data_repository.dart';
import 'package:notrenetflix/ui/widgets/action_button.dart';
import 'package:notrenetflix/ui/widgets/casting_card.dart';
import 'package:notrenetflix/ui/widgets/galerie_card.dart';
import 'package:notrenetflix/ui/widgets/movie_info.dart';
import 'package:notrenetflix/ui/widgets/my_video_player.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;
  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitCircle(
                color: kPrimaryColor,
                size: 50.0,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: newMovie!.videos == null
                        ? const Center(
                            child: Text(
                              "Aucune vidéo disponible",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : MoviePlayer(movieId: newMovie!.videos!.first),
                  ),
                  MovieInfo(
                    movie: newMovie,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: "Lecture",
                    icon: Icons.play_arrow,
                    bgColor: Colors.white,
                    color: kBackgroundColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: "Télécharger",
                    icon: Icons.download,
                    bgColor: Colors.grey.withOpacity(0.3),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(newMovie!.description,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Casting",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: newMovie!.casting!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return newMovie!.casting![index].imageUrl == null
                            ? const Center(
                                child: Text(
                                  "Aucun acteur disponible",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : CastingCard(person: newMovie!.casting![index]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Galerie",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: newMovie!.images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GalerieCard(
                              posterPath: newMovie!.images![index]);
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
