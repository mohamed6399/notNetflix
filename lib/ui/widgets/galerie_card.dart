import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:notrenetflix/services/api.dart';

class GalerieCard extends StatelessWidget {
  final String posterPath;
  const GalerieCard({super.key, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: API().imageUrl + posterPath,
            width: 350,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
        ));
  }
}
