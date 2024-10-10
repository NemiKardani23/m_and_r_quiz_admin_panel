import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_and_r_quiz_admin_panel/theme/font_style.dart';
import 'package:m_and_r_quiz_admin_panel/utills/extentions/padding_extention/padding_extention.dart';
import 'package:m_and_r_quiz_admin_panel/utills/extentions/size_extention/size_extention.dart';
import 'package:m_and_r_quiz_admin_panel/utills/font_size/nk_font_size.dart';
import 'package:m_and_r_quiz_admin_panel/utills/shape/nk_general_size.dart';
import 'package:m_and_r_quiz_admin_panel/utills/spacing/nk_spacing.dart';
import 'package:m_and_r_quiz_admin_panel/utills/text_field_fun/decoration_utils.dart';

import 'color/colors.dart';

class NkTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      shadowColor: shadowColor,
      highlightColor: transparent,
      splashColor: transparent,
      splashFactory: NoSplash.splashFactory,
      primaryColor: primaryColor,
      primaryColorLight: primaryColor,
      primaryColorDark: primaryColor,
      cardTheme: CardTheme(
          surfaceTintColor: primaryContainerBGColor,
          margin: 10.all,
          shadowColor: shadowColor,
          color: primaryContainerBGColor,
          elevation: NkGeneralSize.nkCommoElevation,
          shape: RoundedRectangleBorder(
            borderRadius: NkGeneralSize.nkCommonBorderRadius,
          )),
      scaffoldBackgroundColor: backgroundColor,
      switchTheme: SwitchThemeData(
          thumbColor: WidgetStateColor.resolveWith((states) => selectionColor),
          trackColor:
              WidgetStateColor.resolveWith((states) => revenueProgressBarColor),
          trackOutlineColor:
              WidgetStateColor.resolveWith((states) => transparent)),
      navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
              NkGetXFontStyle.primaryTextTheme(context)
                  .labelMedium
                  ?.copyWith(fontSize: 14)),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: secondaryColor),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      appBarTheme: appBarTheme,
      textTheme: NkGetXFontStyle.primaryTextTheme(context),
      primaryTextTheme: NkGetXFontStyle.primaryTextTheme(context),
      dividerColor: dividerColor,
      listTileTheme: listTileThemeData(context),
      expansionTileTheme: const ExpansionTileThemeData(
          iconColor: primaryIconColor,
          collapsedIconColor: primaryIconColor,
          textColor: primaryTextColor,
          collapsedTextColor: primaryTextColor,
          backgroundColor: Color(0xFF0F172A),
          clipBehavior: Clip.antiAlias,
          tilePadding: EdgeInsets.zero,
          childrenPadding: nkSmallPadding),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        error: errorColor,
        onError: errorColor,
        onSurface: backgroundColor,
        primaryContainer: primaryContainerColor,
        onSecondary: secondaryColor,
        secondaryContainer: secondaryColor,
        surface: backgroundColor,
        secondary: secondaryColor,
      ),
      iconTheme: IconThemeData(
          color: primaryIconColor, size: NkGeneralSize.nkIconSize()),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: secondaryTextColor,
        selectionColor: cursorColor,
        selectionHandleColor: primaryButtonColor,
      ),
      useMaterial3: true,
      iconButtonTheme: const IconButtonThemeData(
          style:
              ButtonStyle(iconColor: WidgetStatePropertyAll(primaryIconColor))),
      primaryIconTheme: IconThemeData(
          color: primaryIconColor, size: NkGeneralSize.nkIconSize()),
      brightness: Brightness.light,
      popupMenuTheme: PopupMenuThemeData(
        textStyle: TextStyle(
            color: primaryTextColor, fontSize: NkFontSize.regularFont),
        color: primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: NkGeneralSize.nkCommonSmoothBorderRadius),
        elevation: 10,
        position: PopupMenuPosition.under,
        shadowColor: shadowColor,
      ),
      menuButtonTheme: MenuButtonThemeData(
          style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(TextStyle(
            color: primaryTextColor, fontSize: NkFontSize.regularFont)),
      )),
      menuTheme: const MenuThemeData(
          style: MenuStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: NkGeneralSize.nkCommonSmoothBorderRadius)),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              backgroundColor: WidgetStatePropertyAll(secondaryColor),
              elevation: WidgetStatePropertyAll(10),
              mouseCursor: WidgetStatePropertyAll(MouseCursor.defer))),
      dropdownMenuTheme:
          DropdownMenuThemeData(menuStyle: const MenuStyle(backgroundColor: WidgetStatePropertyAll(primaryColor)), textStyle: TextStyle(color: primaryTextColor, fontSize: NkFontSize.regularFont), inputDecorationTheme: InputDecorationTheme(suffixIconColor: primaryIconColor, focusColor: DecorationUtils(context).getUnderlineInputDecoration().focusColor, focusedBorder: DecorationUtils(context).getUnderlineInputDecoration().focusedBorder, counterStyle: DecorationUtils(context).getUnderlineInputDecoration().counterStyle, contentPadding: DecorationUtils(context).getUnderlineInputDecoration().contentPadding, errorBorder: DecorationUtils(context).getUnderlineInputDecoration().errorBorder, enabledBorder: DecorationUtils(context).getUnderlineInputDecoration().enabledBorder, disabledBorder: DecorationUtils(context).getUnderlineInputDecoration().disabledBorder, errorStyle: DecorationUtils(context).getUnderlineInputDecoration().errorStyle, hintStyle: DecorationUtils(context).getUnderlineInputDecoration().hintStyle, errorMaxLines: DecorationUtils(context).getUnderlineInputDecoration().errorMaxLines, fillColor: DecorationUtils(context).getUnderlineInputDecoration().fillColor, focusedErrorBorder: DecorationUtils(context).getUnderlineInputDecoration().focusedErrorBorder, border: DecorationUtils(context).getUnderlineInputDecoration().border)),
      searchBarTheme: searchBarThemeData(context),
      tabBarTheme: tabBarTheme,
      dialogTheme: dialogTheme,
      buttonTheme: ButtonThemeData(
          buttonColor: primaryButtonColor,
          textTheme: ButtonTextTheme.normal,
          padding: nkRegularPadding,
          height: context.height * 0.06,
          disabledColor: primaryButtonColor,
          focusColor: primaryButtonColor,
          layoutBehavior: ButtonBarLayoutBehavior.padded,
          shape: RoundedRectangleBorder(
            borderRadius: NkGeneralSize.nkCommonBorderRadius,
          )),
      datePickerTheme: datePickerThemeData(context),
      scrollbarTheme: scrollbarTheme,
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryButtonColor),
        ),
       side: BorderSide(color: primaryButtonColor),
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryButtonColor;
          } else {
            return transparent;
          }
        }),
      ));

  static ListTileThemeData listTileThemeData(BuildContext context) =>
      const ListTileThemeData(
          iconColor: primaryIconColor, contentPadding: nkRegularPadding);

  static SearchBarThemeData searchBarThemeData(BuildContext context) =>
      SearchBarThemeData(
        backgroundColor: const WidgetStatePropertyAll(secondaryBackgroundColor),
        elevation: const WidgetStatePropertyAll(0),
        shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: NkGeneralSize.nkCommonSmoothBorderRadius,
        )),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            color: primaryTextColor,
            fontSize: NkFontSize.smallFont,
          ),
        ),
        hintStyle: WidgetStatePropertyAll(
          TextStyle(
              color: primaryTextColor.withOpacity(0.2),
              fontSize: NkFontSize.regularFont),
        ),
        padding: WidgetStatePropertyAll(10.all),
      );

  static AppBarTheme get appBarTheme => const AppBarTheme(
      color: backgroundColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      shadowColor: shadowColor,
      centerTitle: true,
      titleTextStyle: TextStyle());

  static get systemChromeStyle => {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: backgroundColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: backgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        )),
        SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
        )
      };

  static DatePickerThemeData datePickerThemeData(BuildContext context) =>
      DatePickerThemeData(
          todayBackgroundColor: const WidgetStatePropertyAll(secondaryColor),
          todayBorder:
              WidgetStateBorderSide.resolveWith((states) => const BorderSide(
                    color: errorColor,
                  )),
          yearStyle: TextStyle(
            color: primaryTextColor,
            fontSize: NkFontSize.regularFont,
          ),
          yearForegroundColor: const WidgetStatePropertyAll(primaryTextColor),
          backgroundColor: secondaryBackgroundColor,
          dayForegroundColor: const WidgetStatePropertyAll(primaryTextColor),
          dayOverlayColor: const WidgetStatePropertyAll(selectionColor),
          headerHeadlineStyle: const TextStyle(
            color: primaryTextColor,
          ),
          headerHelpStyle: const TextStyle(
            color: primaryTextColor,
          ),
          cancelButtonStyle: const ButtonStyle(
              textStyle: WidgetStatePropertyAll(TextStyle(
            color: primaryTextColor,
          ))),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: textFieldBgColor,
            filled: true,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(8.0),
            labelStyle: TextStyle(
              color: secondaryTextColor,
              fontSize: NkFontSize.smallFont,
            ),
            hintStyle: const TextStyle(
              color: secondaryTextColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hoverColor: transparent,
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  const BorderSide(color: textFieldBorderColor, width: 1.0),
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide:
                  const BorderSide(color: textFieldBorderColor, width: 1.0),
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  const BorderSide(color: textFieldBorderColor, width: 1.0),
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: errorColor, width: 1.0),
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: errorColor, width: 1.0),
              borderRadius: NkGeneralSize.nkCommonBorderRadius,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: NkGeneralSize.nkCommonSmoothBorderRadius,
          ),
          dayStyle: const TextStyle(
            color: primaryTextColor,
          ),
          rangePickerHeaderHeadlineStyle:
              const TextStyle(color: primaryTextColor),
          rangePickerHeaderHelpStyle: const TextStyle(color: primaryTextColor),
          rangePickerBackgroundColor: secondaryBackgroundColor);

  static DialogTheme get dialogTheme => DialogTheme(
        backgroundColor: secondaryBackgroundColor,
        elevation: 0,
        contentTextStyle: const TextStyle(
          color: primaryTextColor,
        ),
        titleTextStyle: TextStyle(
          color: primaryTextColor,
          fontSize: NkFontSize.headingFont,
        ),
        // actionsPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: NkGeneralSize.nkCommonSmoothBorderRadius,
        ),
      );

  static TabBarTheme get tabBarTheme => TabBarTheme(
        labelColor: selectionColor,
        unselectedLabelColor: primaryTextColor,
        indicatorColor: selectionColor,
        labelPadding: 0.all,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
      );

  static ScrollbarThemeData get scrollbarTheme => ScrollbarThemeData(
        interactive: true,
        mainAxisMargin: 10,
        crossAxisMargin: 10,
        radius: const Radius.circular(10),
        thickness: WidgetStateProperty.all(6),
        thumbVisibility: const WidgetStatePropertyAll(true),
        thumbColor:
            WidgetStatePropertyAll(textFieldInputTextColor.withOpacity(0.5)),
      );
}
