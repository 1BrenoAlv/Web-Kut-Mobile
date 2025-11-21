import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontsConst {
  static final TextStyle tituloPost = GoogleFonts.poppins(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle conteudoPost = GoogleFonts.poppins(
    color: const Color.fromARGB(255, 255, 255, 255),
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nomeAuthorPost = GoogleFonts.poppins(
    color: const Color.fromRGBO(101, 96, 234, 1),
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
}
