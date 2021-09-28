import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final appBarTitle = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final primaryMessage = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );

  static final errorMessage = GoogleFonts.lexendDeca(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.red[900],
  );

  static final snackbarMessage = GoogleFonts.lexendDeca(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final titlePost = GoogleFonts.lexendDeca(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static final subTitlePost = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.lightGrey,
  );

  static final bottomNavigationTitlePrimary = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColor,
  );

  static final bottomNavigationTitle = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.lightGrey,
  );
}
