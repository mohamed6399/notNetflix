import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notrenetflix/models/movie.dart';
import 'package:notrenetflix/ui/screen/movie_details_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: movie.posterURL(),
        fit: BoxFit.cover,
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
