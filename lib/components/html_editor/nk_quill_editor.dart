import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_html_viewer/nk_html_viewer_web.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart'; // Your app imports
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    as core show HtmlWidget;

class NkQuillEditor extends StatefulWidget {
  final quill.QuillController controller;
  final Function(bool unSelected)? unSelect;
  final String? hint;
  final bool isSelected;
  final bool isReaDOnly;
  final BoxBorder? border;
  final GlobalKey<quill.EditorState>? editorKey;
  const NkQuillEditor({
    this.isSelected = false,
    this.isReaDOnly = false,
    this.unSelect,
    super.key,
    this.editorKey,
    required this.controller,
    this.hint,
    this.border,
  });

  @override
  State<NkQuillEditor> createState() => _NkQuillEditorState();
}

class _NkQuillEditorState extends State<NkQuillEditor> {
  @override
  void initState() {
    if (widget.isReaDOnly) {
      widget.controller.readOnly = true;
      widget.controller.editorFocusNode?.unfocus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReaDOnly) {
      return core.HtmlWidget(
        quillDeltaToHtml(widget.controller.document.toDelta().toJson()),
        factoryBuilder: () => NkHtmlViewerWEB(),
        customWidgetBuilder: (element) {
          if (element.localName == 'img') {
            return MyNetworkImage(imageUrl: element.attributes['src'] ?? "",appHeight: (context.size?.longestSide??0)* 0.2,
              appWidth: (context.size?.longestSide??0)* 0.2,);
          }
          return null;
        },
        renderMode: RenderMode.column,
      );
    } else {
      return quillEditor(context);
    }
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
        child: MyCommnonContainer(
          // padding: 10.all.copyWith(left: 0),
          border: widget.border ??
              Border.all(
                  color:
                      widget.isSelected ? selectionColor : textFieldBorderColor,
                  width: 1),
          // borderRadiusGeometry: BorderRadius.zero,
          child: quill.QuillEditor.basic(
            controller: widget.controller,
            configurations: quill.QuillEditorConfigurations(
                editorKey: widget.editorKey,
                padding: 10.all,
                showCursor: !widget.isReaDOnly,
                autoFocus: !widget.isReaDOnly,
                floatingCursorDisabled: true,
                placeholder: widget.hint ?? "Write something...",
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
      ),
    );
  }

  /// Method to get the HTML content from the editor
  String? getHtmlText() {
    var jsonDelta = widget.controller.document.toDelta().toJson();
    var htmlText = quillDeltaToHtml(jsonDelta);
    debugPrint(htmlText);
    return htmlText;
  }

  /// Method to insert a network image
  void insertNetworkImage(String url) async {
    widget.controller.document.insert(0, quill.BlockEmbed.image(url));
  }

  /// Method to insert a video URL
  void insertVideoURL(String url) async {
    widget.controller.document.insert(0, quill.BlockEmbed.video(url));
  }

  /// Method to clear the editor content
  void clearEditor() {
    widget.controller.clear();
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
      child: quill.QuillToolbar.simple(
        controller: controller,
        configurations: quill.QuillSimpleToolbarConfigurations(
          multiRowsDisplay: true,
          sectionDividerColor: black,
          toolbarIconAlignment: WrapAlignment.start,
          toolbarIconCrossAlignment: WrapCrossAlignment.start,
          axis: Axis.horizontal,
          buttonOptions: const _NkQuillToolbarButtonOptions(),
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
      ),
    );
  }
}

class _NkQuillToolbarButtonOptions
    extends quill.QuillSimpleToolbarButtonOptions {
  const _NkQuillToolbarButtonOptions()
      : super(
          base: const quill.QuillToolbarBaseButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          undoHistory: const quill.QuillToolbarHistoryButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          redoHistory: const quill.QuillToolbarHistoryButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          fontFamily: const quill.QuillToolbarFontFamilyButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          // fontSize: const quill.QuillToolbarFontSizeButtonOptions(

          //   iconTheme: quill.QuillIconTheme(
          //     iconButtonSelectedData: quill.IconButtonData(
          //       color: selectionColor,
          //       highlightColor: selectionColor,
          //     ),
          //     iconButtonUnselectedData: quill.IconButtonData(
          //       color: primaryIconColor,
          //     ),
          //   ),
          // ),
          bold: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          italic: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          subscript: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          superscript: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          small: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          underLine: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          strikeThrough: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          inlineCode: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          direction: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          listNumbers: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          listBullets: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          codeBlock: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          quote: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          toggleCheckList: const quill.QuillToolbarToggleCheckListButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          indentIncrease: const quill.QuillToolbarIndentButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          indentDecrease: const quill.QuillToolbarIndentButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          color: const quill.QuillToolbarColorButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          backgroundColor: const quill.QuillToolbarColorButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          clearFormat: const quill.QuillToolbarClearFormatButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          selectAlignmentButtons:
              const quill.QuillToolbarSelectAlignmentButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          search: const quill.QuillToolbarSearchButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          selectHeaderStyleButtons:
              const quill.QuillToolbarSelectHeaderStyleButtonsOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          selectHeaderStyleDropdownButton:
              const quill.QuillToolbarSelectHeaderStyleDropdownButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          linkStyle: const quill.QuillToolbarLinkStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          linkStyle2: const quill.QuillToolbarLinkStyleButton2Options(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          customButtons: const quill.QuillToolbarCustomButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          clipboardCut: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          clipboardCopy: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
          clipboardPaste: const quill.QuillToolbarToggleStyleButtonOptions(
            iconTheme: quill.QuillIconTheme(
              iconButtonSelectedData: quill.IconButtonData(
                color: selectionColor,
                highlightColor: selectionColor,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(selectionColor),
                ),
              ),
              iconButtonUnselectedData: quill.IconButtonData(
                color: primaryIconColor,
              ),
            ),
          ),
        );
}
