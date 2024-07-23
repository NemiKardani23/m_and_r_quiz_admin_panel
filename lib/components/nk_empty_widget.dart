import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';
import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';
import 'package:m_and_r_quiz_admin_panel/utills/string/nk_string.dart';

class NkEmptyWidget extends StatelessWidget {
  final String? errorMessage;
  final Color? textColor;
  const NkEmptyWidget({super.key, this.errorMessage, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyRegularText(
        label: errorMessage ?? ErrorStrings.noDataFound,
        color: textColor,
        fontSize: NkFontSize.regularFont,
      ),
    );
  }
}
