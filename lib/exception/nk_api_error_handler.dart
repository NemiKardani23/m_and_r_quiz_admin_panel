import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionmanager.dart';

import '../export/___app_file_exporter.dart';

class NkApiErrorHandler {
  handleUnAuthanTicateError({required String message, required int code}) {
    switch (code) {
      case APIStatusCode.UNAUTHORIZED:
        {
          resetAppAuth();
        }
        break;
      default:
        {
          NKToast.error(
              title: ErrorStrings.sessionExpired, description: message);
        }
    }
  }

  resetAppAuth() async {
    await SessionManager.clearData();
    NKToast.error(
        title: ErrorStrings.sessionExpired,
        description: ErrorStrings.sessionExpired);
    await AppRoutes.navigator.pushReplacementNamed(
      AppRoutes.loginScreen,
    );
  }
}
