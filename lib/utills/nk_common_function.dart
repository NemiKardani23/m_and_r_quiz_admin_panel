import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkCommonFunction {
  static Widget passwordIcon(bool isShow) {
    if (isShow) {
      return const Icon(Icons.visibility);
    } else {
      return const Icon(Icons.visibility_off);
    }
  }
}
