import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionmanager.dart';
import 'package:m_and_r_quiz_admin_panel/utills/string/nk_string.dart';
import 'package:m_and_r_quiz_admin_panel/utills/toast/nk_toast.dart';

class NkApiErrorHandler {
  handleUnAuthanTicateError({required String message, required int code}) {}

  resetAppAuth() async {
    await SessionManager.clearData();
    NKToast.error(
        title: ErrorStrings.sessionExpired,
        description: ErrorStrings.sessionExpired);
    // await AppRoutes.navigator.pushNamedAndRemoveUntil(
    //   AppRoutes.loginScreen,
    //   (route) => false,
    // );
  }
}
