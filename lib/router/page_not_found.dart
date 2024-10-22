import 'package:m_and_r_quiz_admin_panel/components/nk_html_viewer/nk_html_view_page_web.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart'
    hide rootBundle;
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart'
    show rootBundle;

// import 'package:flutter/services.dart' show rootBundle;

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _assetsHtmlContent(context),
      builder: (context, snapshot) {
        return NkHtmlViewPageWeb(htmlData: snapshot.data ?? "",onTap: (event) {
          if (event?.data == 'goToHome') {
        // Handle the event - navigate to home or perform any other action
        AppRoutes.navigator
            .goNamed(AppRoutes.dashboardScreen); // Example: navigation to home
      }
        },);
      },
    );
  }

  Future<String> _assetsHtmlContent(BuildContext context) async {
    return await rootBundle.loadString(Assets.assetsPageNotFound);
  }
}
