import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';
import 'package:m_and_r_quiz_admin_panel/theme/color/colors.dart';
import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';
import 'package:m_and_r_quiz_admin_panel/utills/shape/nk_general_size.dart';
import 'package:m_and_r_quiz_admin_panel/utills/spacing/nk_spacing.dart';

class NkSearchableDropDownMenu<T> extends StatelessWidget {
  final String? hintText;
  final void Function(T?)? onSelected;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final TextEditingController? textEditingController;
  final bool? enableFilter;
  final bool? enableSearch;
  final bool? enabled;
  final Widget? trailingIcon;
  final T? initialSelection;
  final double? width;
  final Color? fillColor;
  final InputDecorationTheme? inputDecorationTheme;
  final InputBorder? inputBorder;

  const NkSearchableDropDownMenu(
      {super.key,
      this.hintText,
      this.onSelected,
      required this.dropdownMenuEntries,
      this.textEditingController,
      this.enableFilter,
      this.enableSearch,
      this.enabled,
      this.trailingIcon,
      this.initialSelection,
      this.width,
      this.fillColor,
      this.inputDecorationTheme,
      this.inputBorder});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      label: MyRegularText(
        label: hintText ?? "",
        color: primaryTextColor,
        maxlines: 1,
        fontSize: NkFontSize.smallFont,
      ),
      inputDecorationTheme: inputDecorationTheme ?? menuDecorationTheme,
      dropdownMenuEntries: dropdownMenuEntries,
      onSelected: onSelected,
      controller: textEditingController,
      enableFilter: enableFilter ?? false,
      enableSearch: enableSearch ?? true,
      enabled: enabled ?? true,
      trailingIcon: trailingIcon,
      initialSelection: initialSelection,
      width: width,
    );
  }

  get menuDecorationTheme => InputDecorationTheme(
      fillColor: fillColor ?? backgroundColor,
      filled: true,
      contentPadding: nkSmallPadding,
      suffixIconColor: primaryIconColor,
      labelStyle: TextStyle(
        color: primaryTextColor,
        fontSize: NkFontSize.smallFont,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      disabledBorder: inputBorder ??
          OutlineInputBorder(
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
              borderSide:
                  BorderSide(color: textFieldBorderColor.withOpacity(0.5))),
      enabledBorder: inputBorder ??
          OutlineInputBorder(
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
              borderSide:
                  BorderSide(color: textFieldBorderColor.withOpacity(0.5))),
      focusedBorder: inputBorder ??
          OutlineInputBorder(
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
              borderSide: const BorderSide(color: textFieldBorderColor)),
      border: inputBorder ??
          OutlineInputBorder(
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
              borderSide:
                  BorderSide(color: textFieldBorderColor.withOpacity(0.5))),
      hintStyle: TextStyle(
        color: primaryTextColor,
        fontSize: NkFontSize.smallFont,
      ),
      iconColor: primaryIconColor);
}
