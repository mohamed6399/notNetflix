import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notrenetflix/models/person.dart';
import 'package:notrenetflix/services/api.dart';

class CastingCard extends StatelessWidget {
  final Person person;
  const CastingCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: API().imageUrl + person.imageUrl!,
              width: 160,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            child: SizedBox(
              width: 150,
              child: Text(person.name,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: SizedBox(
              width: 150,
              child: Text(person.characterName,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }
}
