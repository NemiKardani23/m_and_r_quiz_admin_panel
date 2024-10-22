import 'package:google_fonts/google_fonts.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

/// [NkGetXFontStyle] USE CUSTOM FONT

class NkGetXFontStyle {
  static const primaryCustomFontStyle = "Helvetica";

  static TextTheme primaryTextTheme(BuildContext context) =>
      GoogleFonts.poppinsTextTheme().apply(
        bodyColor: primaryTextColor,
        decorationColor: primaryTextColor,
      );
}
