// import 'package:flutter/material.dart';
// import 'package:m_and_r_quiz_admin_panel/components/my_regular_text.dart';
// import 'package:m_and_r_quiz_admin_panel/theme/color/colors.dart';
// import 'package:m_and_r_quiz_admin_panel/utills/extentions/padding_extention/padding_extention.dart';
// import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';
// import 'package:m_and_r_quiz_admin_panel/utills/shape/nk_general_size.dart';
//
// class NkMultiSelectionDropDown<T> extends StatelessWidget {
//   final List<ValueItem<T>> options;
//   final String? hint;
//   final void Function(List<ValueItem<T>>)? onOptionSelected;
//   const NkMultiSelectionDropDown(
//       {super.key, required this.options, this.onOptionSelected, this.hint});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiSelectDropDown<T>(
//       onOptionSelected: onOptionSelected,
//       options: options,
//       hint: hint ?? "Select Options",
//       hintFontSize: NkFontSize.regularFont,
//       fieldBackgroundColor: textFieldBgColor,
//       borderColor: textFieldBorderColor,
//       inputDecoration: UnderlineTabIndicator(
//           borderRadius: NkGeneralSize.nkCommonBorderRadius,
//           borderSide: const BorderSide(
//             color: textFieldBorderColor,
//             width: 0.5,
//             style: BorderStyle.solid,
//           ),
//           insets: 12.horizontal),
//       radiusGeometry: NkGeneralSize.nkCommonBorderRadius,
//       hintColor: secondaryTextColor,
//       optionsBackgroundColor: textFieldBgColor,
//       dropdownBackgroundColor: textFieldBgColor,
//       dropdownMargin: 8.0,
//       dropdownBorderRadius: 16,
//       padding: EdgeInsets.zero,
//       optionTextStyle: const MyRegularText(
//         label: '',
//       ).style,
//       searchEnabled: true,
//       chipConfig: ChipConfig(
//         deleteIcon: const Icon(Icons.close),
//         backgroundColor: revenueProgressBarColor.withOpacity(0.5),
//         wrapType: WrapType.wrap,
//       ),
//     );
//   }
// }
