import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notrenetflix/models/movie.dart';
import 'package:notrenetflix/ui/widgets/movie_card.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie> moviList;
  final double imageHeight;
  final double imageWidth;
  final Function callback;
  const MovieCategory({
    super.key,
    required this.label,
    required this.moviList,
    required this.imageHeight,
    required this.imageWidth,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final currentPosition = notification.metrics.pixels;
              print("curent posintion: $currentPosition");
              final maxPosition = notification.metrics.maxScrollExtent;
              print("max posintion: $maxPosition");
              if (currentPosition >= maxPosition / 2) {
                print("on est au bout de la liste");
                callback();
              }
              return true;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: imageWidth,
                  child: moviList.isNotEmpty
                      ? MovieCard(movie: moviList[index])
                      : const Center(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
