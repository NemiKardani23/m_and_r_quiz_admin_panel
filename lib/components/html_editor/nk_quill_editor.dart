import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart'; // Your app imports

class NkQuillEditor extends StatelessWidget {
  final quill.QuillController controller;
  final Function(bool unSelected)? unSelect;
  final String? hint;
  final bool isSelected;
  final BoxBorder? border;
  const NkQuillEditor({
    this.isSelected = false,
    this.unSelect,
    super.key,
    required this.controller,
    this.hint,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return quillEditor(context);
  }

  Widget quillEditor(BuildContext context) {
    var themeData = Theme.of(context).copyWith(
      cardTheme: const CardTheme(color: transparent, elevation: 0),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: secondaryColor),
      sliderTheme: const SliderThemeData(
          thumbColor: Colors.green,
          activeTrackColor: secondaryColor,
          inactiveTrackColor: secondaryColor,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20)),
      dialogBackgroundColor: primaryColor,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: primaryTextColor,
        textStyle: const TextStyle(color: primaryTextColor),
      )),
      dialogTheme: const DialogTheme(
          iconColor: primaryIconColor,
          backgroundColor: primaryColor,
          surfaceTintColor: primaryColor,
          contentTextStyle: TextStyle(color: primaryTextColor),
          titleTextStyle: TextStyle(color: primaryTextColor)),
      checkboxTheme: const CheckboxThemeData(
          checkColor: WidgetStatePropertyAll(secondaryColor),
          fillColor: WidgetStatePropertyAll(selectionColor)),
    );
    return Theme(
      data: themeData,
      child: CupertinoTheme(
        data: const CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: secondaryColor,
            applyThemeToAll: true,
            primaryContrastingColor: secondaryColor),
        child: Column(
          children: [
            MyCommnonContainer(
              // padding: 10.all.copyWith(left: 0),
              border: border ??
                  Border.all(
                      color: isSelected ? selectionColor : textFieldBorderColor,
                      width: 1),
              // borderRadiusGeometry: BorderRadius.zero,
              child: quill.QuillEditor.basic(
                controller: controller,
                configurations: quill.QuillEditorConfigurations(
                    padding: 10.all,
                    placeholder: hint ?? "Write something...",
                    paintCursorAboveText: true,
                    embedBuilders: kIsWeb
                        ? FlutterQuillEmbeds.editorWebBuilders()
                        : FlutterQuillEmbeds.editorBuilders(),
                    maxHeight: 300,
                    dialogTheme: const quill.QuillDialogTheme(
                      dialogBackgroundColor: primaryColor,
                      isWrappable: true,
                      buttonTextStyle: TextStyle(color: primaryTextColor),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Method to get the HTML content from the editor
  String? getHtmlText() {
    var jsonDelta = controller.document.toDelta().toJson();
    var htmlText = quillDeltaToHtml(jsonDelta);
    debugPrint(htmlText);
    return htmlText;
  }

  /// Method to insert a network image
  void insertNetworkImage(String url) async {
    controller.document.insert(0, quill.BlockEmbed.image(url));
  }

  /// Method to insert a video URL
  void insertVideoURL(String url) async {
    controller.document.insert(0, quill.BlockEmbed.video(url));
  }

  /// Method to clear the editor content
  void clearEditor() {
    controller.clear();
  }

  /// Method to remove focus from the editor
  void unFocusEditor() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

/// Helper function to convert Quill Delta to HTML
String quillDeltaToHtml(List<Map<String, dynamic>> delta) {
  final converter = QuillDeltaToHtmlConverter(
    delta,
    ConverterOptions.forEmail(),
  );

  final html = converter.convert();
  nkDevLog("HTML CODEEEE \n$html");

  return html;
}

class NkQuillToolbar extends StatelessWidget {
  final quill.QuillController? controller;

  const NkQuillToolbar({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return quill.QuillToolbar.simple(
      controller: controller,
      configurations: quill.QuillSimpleToolbarConfigurations(
        multiRowsDisplay: true,
        sectionDividerColor: black,
        axis: Axis.horizontal,
        dialogTheme: const quill.QuillDialogTheme(
          dialogBackgroundColor: primaryColor,
          isWrappable: true,
          buttonTextStyle: TextStyle(color: primaryTextColor),
        ),
        embedButtons: FlutterQuillEmbeds.toolbarButtons(
            imageButtonOptions: const QuillToolbarImageButtonOptions(
                dialogTheme: quill.QuillDialogTheme(
          dialogBackgroundColor: primaryColor,
          isWrappable: true,
          buttonTextStyle: TextStyle(color: primaryTextColor),
        ))),
      ),
    );
  }
}
