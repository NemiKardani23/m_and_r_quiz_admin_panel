import 'dart:convert';

import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/null_check_oprations.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sessionmanager.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/sp_string.dart';

class SessionHelper {
  SessionHelper();
  static SessionHelper get instance => SessionHelper()._internal;
  static set instance(SessionHelper instance) =>
      SessionHelper.instance = instance;

  SessionHelper get _internal {
    getLoginData().then((value) {
      loginResponse = value;
    });
    return this;
  }

  static UserDetails? loginResponse;

  Future<void> setLoginData(UserDetails loginResponce) async {
    // save user values in shared pref
    await SessionManager.setStringValue(
        SpString.spLogin, jsonEncode(loginResponce.toMap()));
    loginResponse = loginResponce;
  }

  Future<UserDetails?> getLoginData() async {
    String? response = await SessionManager.getStringValue(SpString.spLogin);
    if (CheckNullData.checkNullOrEmptyString(response ?? '')) {
      return null;
    } else {
      final jsonOBJ = UserDetails.fromJson(jsonDecode(response ?? ''));
      loginResponse = jsonOBJ;
      return jsonOBJ;
    }
  }
}
