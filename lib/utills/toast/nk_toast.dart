import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';
import 'package:m_and_r_quiz_admin_panel/router/routes.dart';
import 'package:m_and_r_quiz_admin_panel/theme/color/colors.dart';
import 'package:m_and_r_quiz_admin_panel/utills/shape/nk_general_size.dart';
import 'package:toastification/toastification.dart';

class NKToast {
  /// Success Color
  static const Color successPrimary = Color(0x014baf0b);
  static const Color successBg = Color(0x014baf0b);

  /// Warning
  static const Color warningPrimary = Color(0x01afac0b);
  static const Color warningBg = Color(0x01afac0b);

  /// Error
  static const Color errorPrimary = Color(0x01af1e0b);
  static const Color errorBg = Color(0x01af1e0b);

  /// Info
  static const Color infoPrimary = Color(0x01af1e0b);
  static const Color infoBg = Color(0x01af1e0b);

  NKToast.success({String? title, String? description, BuildContext? context}) {
    toastification.show(
      context: context ?? AppRoutes.$navigatorKey!.currentContext!,
      alignment: Alignment.bottomCenter,
      primaryColor: successPrimary,
      backgroundColor: successBg,
      applyBlurEffect: true,
      foregroundColor: black,
      style: ToastificationStyle.fillColored,
      animationDuration: NkGeneralSize.nkCommonDuration,
      autoCloseDuration: const Duration(seconds: 3),
      type: ToastificationType.success,
      title: MyRegularText(
        label: title ?? 'Success',
        color: black,
        fontWeight: FontWeight.w600,
      ),
      showProgressBar: false,
      description: description != null
          ? MyRegularText(
              label: description,
              color: black,
            )
          : null,
    );
  }

  NKToast.warning({String? title, String? description, BuildContext? context}) {
    toastification.show(
      context: context ?? AppRoutes.$navigatorKey!.currentContext!,
      alignment: Alignment.bottomCenter,
      primaryColor: warningPrimary,
      applyBlurEffect: true,
      backgroundColor: warningBg,
      foregroundColor: black,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      style: ToastificationStyle.fillColored,
      animationDuration: NkGeneralSize.nkCommonDuration,
      type: ToastificationType.warning,
      title: MyRegularText(
        label: title ?? 'Warning',
        color: black,
        fontWeight: FontWeight.w600,
      ),
      description: description != null
          ? MyRegularText(
              label: description,
              color: black,
            )
          : null,
    );
  }

  NKToast.error({String? title, String? description, BuildContext? context}) {
    toastification.show(
      context: context ?? AppRoutes.$navigatorKey!.currentContext!,
      alignment: Alignment.bottomCenter,
      primaryColor: errorPrimary,
      backgroundColor: errorBg,
      applyBlurEffect: true,
      foregroundColor: black,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      style: ToastificationStyle.fillColored,
      animationDuration: NkGeneralSize.nkCommonDuration,
      type: ToastificationType.error,
      title: MyRegularText(
        label: title ?? 'Error',
        color: black,
        fontWeight: FontWeight.w600,
      ),
      description: description != null
          ? MyRegularText(
              label: description,
              color: black,
            )
          : null,
    );
  }
  NKToast.info({String? title, String? description, BuildContext? context}) {
    toastification.show(
      context: context ?? AppRoutes.$navigatorKey!.currentContext!,
      alignment: Alignment.bottomCenter,
      primaryColor: infoPrimary,
      backgroundColor: infoBg,
      foregroundColor: black,
      style: ToastificationStyle.fillColored,
      applyBlurEffect: true,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      animationDuration: NkGeneralSize.nkCommonDuration,
      type: ToastificationType.info,
      title: MyRegularText(
        label: title ?? 'Info',
        color: black,
        fontWeight: FontWeight.w600,
      ),
      description: description != null
          ? MyRegularText(
              label: description,
              color: black,
            )
          : null,
    );
  }
  static void showToast(String message) {}
}
