import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/theme/color/colors.dart';
import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';
import 'package:m_and_r_quiz_admin_panel/utills/shape/nk_general_size.dart';

class DecorationUtils {
  BuildContext context;

  DecorationUtils(this.context);

  InputDecoration getUnderlineInputDecoration({
    String? labelText = "",
    bool isRequire = false,
    bool isEnable = true,
    final Color? enableColor,
    final Color? disabledColor,
    bool? alignLabelWithHint,
    final Color? focusedColor,
    final Color? labelTextColor,
    final FloatingLabelBehavior? floatingLabelBehavior,
    icon,
    final Widget? prefixIcon,
    final Widget? suffixIcon,
    final BorderRadius? borderRadius,
    final Color? fillColor,
    final Color? hintColor,
    final EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      fillColor: isRequire ? fillColor ?? textFieldBgColor : textFieldBgColor,
      filled: (isEnable) ? true : true,
      alignLabelWithHint: alignLabelWithHint,
      suffixIcon: suffixIcon,
      icon: icon,
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      contentPadding: contentPadding ?? const EdgeInsets.all(8.0),
      labelText: labelText,
      counterText: "",
      labelStyle: TextStyle(
        color: labelTextColor ?? secondaryTextColor,
        fontSize: NkFontSize.smallFont,
      ),
      hintStyle: TextStyle(
        color: hintColor ?? secondaryTextColor,
      ),
      floatingLabelBehavior:
          floatingLabelBehavior ?? FloatingLabelBehavior.auto,
      hoverColor: transparent,
      enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: enableColor ?? textFieldBorderColor, width: 1.0),
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: disabledColor ?? textFieldBorderColor, width: 1.0),
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: focusedColor ?? textFieldBorderColor, width: 1.0),
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: errorColor, width: 1.0),
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: errorColor, width: 1.0),
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
      ),
    );
  }

  InputDecoration getOutlineInputDecoration({
    String? labelText = "",
    bool isRequire = false,
    bool isEnable = true,
    final Color? enableColor,
    final Color? disabledColor,
    bool? alignLabelWithHint,
    final Color? focusedColor,
    final Color? labelTextColor,
    final FloatingLabelBehavior? floatingLabelBehavior,
    icon,
    final Widget? prefixIcon,
    final Widget? suffixIcon,
    final BorderRadius? borderRadius,
    final Color? fillColor,
    final Color? hintColor,
    final EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      fillColor: isRequire ? fillColor ?? textFieldBgColor : textFieldBgColor,
      filled: (isEnable) ? true : true,
      alignLabelWithHint: alignLabelWithHint,
      suffixIcon: suffixIcon,
      icon: icon,
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      contentPadding: contentPadding ?? const EdgeInsets.all(8.0),
      labelText: labelText,
      counterText: "",
      labelStyle: TextStyle(
        color: labelTextColor ?? secondaryTextColor,
        fontSize: NkFontSize.smallFont,
      ),
      hintStyle: TextStyle(
        color: hintColor ?? secondaryTextColor,
      ),
      floatingLabelBehavior:
          floatingLabelBehavior ?? FloatingLabelBehavior.never,
      hoverColor: transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
        borderSide: BorderSide(
          color: enableColor ?? textFieldBorderColor,
          width: 1.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
        borderSide: BorderSide(
          color: disabledColor ?? textFieldBorderColor,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
        borderSide: BorderSide(
          color: focusedColor ?? textFieldBorderColor,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor, width: 1.0),
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor, width: 1.0),
        borderRadius: borderRadius ?? NkGeneralSize.nkCommonBorderRadius,
      ),
    );
  }

   InputDecorationTheme getOutlineInputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: textFieldBgColor,
      filled: true,
      labelStyle: TextStyle(
        color: secondaryTextColor,
        fontSize: NkFontSize.smallFont,
      ),
      hintStyle: const TextStyle(
        color: secondaryTextColor,
      ),
      enabledBorder: getOutlineInputDecoration(
        isEnable: true,
        enableColor: textFieldBorderColor,
        borderRadius: NkGeneralSize.nkCommonBorderRadius,
      ).enabledBorder,
      focusedBorder: getOutlineInputDecoration(
        isEnable: true,
        focusedColor: textFieldBorderColor,
        borderRadius: NkGeneralSize.nkCommonBorderRadius,
      ).focusedBorder,
      errorBorder: getOutlineInputDecoration(
        isEnable: false,
      ).errorBorder,
      focusedErrorBorder: getOutlineInputDecoration(
        isEnable: false,
      ).focusedErrorBorder,
    );
  }
}
