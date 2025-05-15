import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color color;
  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(
            width: 8,
          ),
          Text(label,
              style: GoogleFonts.poppins(
                  color: color, fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
