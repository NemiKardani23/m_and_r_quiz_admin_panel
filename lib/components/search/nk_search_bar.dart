import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/theme/color/colors.dart';
import 'package:m_and_r_quiz_admin_panel/utills/extentions/size_extention/size_extention.dart';

class NkSearchBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String hint;
  final Color backgroundFieldColor;
  const NkSearchBar(
      {super.key,
      this.onChanged,
      this.controller,
      required this.hint,
      this.backgroundFieldColor = secondaryBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return _searchBar(hint);
  }

  NkSearchBar.web(
      {super.key,
      this.onChanged,
      this.controller,
      required this.hint,
      this.backgroundFieldColor = secondaryBackgroundColor,
      required BuildContext context,
      BoxConstraints? constraints}) {
    _web(context, constraints: constraints);
  }

  Widget _web(BuildContext context, {BoxConstraints? constraints}) {
    return TextFormField(
      controller: controller,
      onEditingComplete: () {
        //controller.getSearch(controller.searchEditingController.text);
      },
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: primaryTextColor),
      decoration: InputDecoration(
        constraints:
            constraints ?? BoxConstraints(minWidth: context.width * 0.2),
        prefixIcon: const Icon(Icons.search, color: primaryIconColor),
        fillColor: backgroundFieldColor,
        filled: true,
        isDense: true,
        errorMaxLines: 3,
        contentPadding: const EdgeInsets.all(18.0),
        labelText: hint,
        counterText: "",
        labelStyle: const TextStyle(color: secondaryTextColor),
        hintStyle: const TextStyle(color: secondaryTextColor),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: transparent, width: 0.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: transparent, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: transparent, width: 0.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: errorColor, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: errorColor, width: 0.0),
        ),
      ),
    );
  }

  Widget _searchBar(String hint) {
    return TextFormField(
      controller: controller,
      onEditingComplete: () {
        //controller.getSearch(controller.searchEditingController.text);
      },
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: primaryTextColor),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: primaryIconColor),
        fillColor: backgroundFieldColor,
        filled: true,
        isDense: true,
        errorMaxLines: 3,
        contentPadding: const EdgeInsets.all(18.0),
        labelText: hint,
        counterText: "",
        labelStyle: const TextStyle(color: secondaryTextColor),
        hintStyle: const TextStyle(color: secondaryTextColor),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: transparent, width: 0.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: transparent, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: transparent, width: 0.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: errorColor, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: errorColor, width: 0.0),
        ),
      ),
    );
  }
}
