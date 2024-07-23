import '../export/___app_file_exporter.dart';

class MyRegularText extends Text {
  final String label;
  final Color? color;
  final double? fontSize;
  final double? letterSpacing;
  final double? height;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final int? maxlines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? stepGranularity;
  final TextStyle? style;
  final TextDecorationStyle? textDecorationStyle;
  final bool isPrimaryFont;
  final bool showEmptyError;
  final String? fontFamily;

  const MyRegularText({
    Key? key,
    required this.label,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.align = TextAlign.center,
    this.maxlines,
    this.decoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
    this.letterSpacing,
    this.stepGranularity,
    this.style,
    this.textDecorationStyle,
    this.showEmptyError = false,
    this.isPrimaryFont = false,
    this.fontFamily,
    this.height,
  }) : super(label);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return showEmptyError == false
        ? Text(label,
            textAlign: align,
            maxLines:
                label.isNotEmpty ? maxlines ?? label.length : maxlines ?? 1,
            softWrap: true,
            //minFontSize: 12,
            overflow: overflow,
            style: style ??
                TextStyle(
                  height: height,
                  color: color ?? primaryTextColor,
                  decorationStyle: textDecorationStyle,
                  fontSize: fontSize ?? NkFontSize.regularFont,
                  letterSpacing: letterSpacing,
                  fontWeight: fontWeight,
                  fontStyle: FontStyle.normal,
                  decoration: decoration,
                  fontFamily: isPrimaryFont
                      ? fontFamily ??
                          theme.primaryTextTheme.labelMedium?.fontFamily
                      : fontFamily ?? theme.textTheme.labelMedium?.fontFamily,

                  //decorationColor: theme.de,
                  decorationThickness: 1,
                ))
        : ErrorWidget.withDetails(
            message: "PLEASE DO NOT EMPTY LIABLE",
            error: FlutterError("PLEASE DO NOT EMPTY LIABLE"),
          );
  }

  // Widget animatedText(BuildContext context) {
  //   ThemeData theme = Theme.of(context);
  //   return showEmptyError == false
  //       ? Text(label,
  //               textAlign: align,
  //               maxLines:
  //                   label.isNotEmpty ? maxlines ?? label.length : maxlines ?? 1,
  //               softWrap: true,
  //               //minFontSize: 12,
  //               overflow: overflow,
  //               style: style ??
  //                   TextStyle(
  //                     height: height,
  //                     color: color ?? primaryTextColor,
  //                     decorationStyle: textDecorationStyle,
  //                     fontSize: fontSize ?? NkFontSize.regularFont,
  //                     letterSpacing: letterSpacing,
  //                     fontWeight: fontWeight,
  //                     fontStyle: FontStyle.normal,
  //                     decoration: decoration,
  //                     fontFamily: isPrimaryFont
  //                         ? fontFamily ??
  //                             theme.primaryTextTheme.labelMedium?.fontFamily
  //                         : fontFamily ??
  //                             theme.textTheme.labelMedium?.fontFamily,
  //
  //                     //decorationColor: theme.de,
  //                     decorationThickness: 1,
  //                   ))
  //       : ErrorWidget.withDetails(
  //           message: "PLEASE DO NOT EMPTY LIABLE",
  //           error: FlutterError("PLEASE DO NOT EMPTY LIABLE"),
  //         );
  // }
}
