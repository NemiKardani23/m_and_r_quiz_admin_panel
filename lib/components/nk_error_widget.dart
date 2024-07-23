import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final Color? textColor;
  const NkErrorWidget({super.key, this.errorMessage, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyRegularText(
        label: errorMessage ?? ErrorStrings.oopsSomethingWentWrong,
        color: textColor,
        fontSize: NkFontSize.smallFont,
      ),
    );
  }
}
