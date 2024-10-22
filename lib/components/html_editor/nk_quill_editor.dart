import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:html/parser.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_html_viewer/nk_html_viewer_web.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/utills/image_upload/nk_multipart.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart'; // Your app imports
// ignore: implementation_imports, library_prefixes
import 'package:flutter_quill_extensions/src/editor_toolbar_shared/image_picker/image_options.dart'
    as $IMG; // Your app imports
// ignore: depend_on_referenced_packages

class NkQuillEditor extends StatefulWidget {
  final quill.QuillController controller;
  final Function(bool unSelected)? unSelect;
  final String? hint;
  final String? initalContent;
  final bool isSelected;
  final bool isReaDOnly;
  final BoxBorder? border;
  final GlobalKey<quill.EditorState>? editorKey;
  const NkQuillEditor({
    this.initalContent,
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
    _setInitialContent();
    if (widget.isReaDOnly) {
      widget.controller.readOnly = true;
      widget.controller.editorFocusNode?.unfocus();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(NkQuillEditor oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the isReaDOnly state has changed
    if (oldWidget.isReaDOnly != widget.isReaDOnly) {
      _setReadOnlyMode();
    }

    // Update the initial content if it's different from the previous one
    if (oldWidget.initalContent != widget.initalContent) {
      _setInitialContent();
    }

    // Handle other parameter updates
    if (oldWidget.isSelected != widget.isSelected ||
        oldWidget.border != widget.border) {
      setState(() {}); // Redraw if selection state or border changed
    }
  }

  void _setReadOnlyMode() {
    if (widget.isReaDOnly) {
      widget.controller.readOnly = true;
      widget.controller.editorFocusNode?.unfocus();
    } else {
      widget.controller.readOnly = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReaDOnly) {
      if (widget.initalContent == null) {
        return FutureBuilder(
          future: getHtmlText(),
          builder: (context, snapshot) {
            return NkHtmlViewerWEB(
              htmlContent: snapshot.data ?? "",
            );
          },
        );
      } else {
        return NkHtmlViewerWEB(
          htmlContent: widget.initalContent!,
        );
      }
    } else {
      return quillEditor(context);
    }
  }

  Widget quillEditor(BuildContext context) {
    var themeData = Theme.of(context).copyWith(
      cupertinoOverrideTheme:  const CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: secondaryColor,
          scaffoldBackgroundColor: black,
          barBackgroundColor: black,
          applyThemeToAll: true,
          primaryContrastingColor: secondaryColor),
      cardTheme: const CardTheme(color: transparent, elevation: 0),
      bottomSheetTheme:
           const BottomSheetThemeData(backgroundColor: secondaryColor),
      sliderTheme:  const SliderThemeData(
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
      dialogTheme:  const DialogTheme(
          iconColor: primaryIconColor,
          backgroundColor: primaryColor,
          surfaceTintColor: primaryColor,
          contentTextStyle: TextStyle(color: primaryTextColor),
          titleTextStyle: TextStyle(color: primaryTextColor)),
      checkboxTheme:  const CheckboxThemeData(
          checkColor: WidgetStatePropertyAll(secondaryColor),
          fillColor: WidgetStatePropertyAll(selectionColor)),
    );
    return Theme(
      data: themeData,
      child: CupertinoTheme(
        data:  const CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: secondaryColor,
            scaffoldBackgroundColor: black,
            barBackgroundColor: black,
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
                //editorKey: widget.editorKey,
                padding: 10.all,
                // showCursor: !widget.isReaDOnly,
                autoFocus: !widget.isReaDOnly,
                floatingCursorDisabled: false,
                placeholder: widget.hint ?? "Write something...",
                embedBuilders: kIsWeb
                    ? FlutterQuillEmbeds.editorWebBuilders()
                    : FlutterQuillEmbeds.editorBuilders(),
                maxHeight: 300,
                dialogTheme:  const quill.QuillDialogTheme(
                  dialogBackgroundColor: primaryColor,
                  isWrappable: true,
                  buttonTextStyle: TextStyle(color: primaryTextColor),
                )),
          ),
        ),
      ),
    );
  }

  _setInitialContent() {
    if (widget.initalContent != null) {
      widget.controller.setContents(htmlToQuillDelta(widget.initalContent)!);
    }
  }

  /// Method to get the HTML content from the editor
  Future<String?> getHtmlText() async {
    var jsonDelta = widget.controller.document.toDelta().toJson();
    var htmlText = await quillDeltaToHtmlAndUpload(jsonDelta);
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

/// Helper function to convert Quill Delta to HTML and upload images
Future<String?> quillDeltaToHtmlAndUpload(
    List<Map<String, dynamic>>? delta) async {
  // A map to store previously uploaded images and their server URLs
  Map<String, String> uploadedImagesCache = {};

  // Log delta entries for debugging
  delta?.forEach((element) {
    nkDevLog("Element: ${element.entries}");
  });

  // Check if delta is null or empty
  if (delta == null || delta.every((x) => x["insert"] == "")) {
    return null;
  }

  // Log delta data
  nkDevLog("DELTA DATA : ${delta.map((x) => x.toString())}");

  // Iterate through the delta and upload images if not already uploaded
  for (var element in delta) {
    if (element.containsKey("insert") && element["insert"] is Map) {
      var insert = element["insert"] as Map;
      if (insert.containsKey("image")) {
        String localImagePath = insert["image"];

        // Check if the image is already uploaded
        if (uploadedImagesCache.containsKey(localImagePath)) {
          // If already uploaded, replace the local path with the stored URL
          nkDevLog("Image already uploaded. Using cached URL.");
          element["insert"] = {"image": uploadedImagesCache[localImagePath]};
        } else {
          // Upload the image to the server
          String? uploadedImageUrl = await uploadImage(localImagePath);

          if (uploadedImageUrl != null) {
            // Replace the local image path with the URL from the server
            element["insert"] = {"image": uploadedImageUrl};

            // Cache the uploaded image path and URL
            uploadedImagesCache[localImagePath] = uploadedImageUrl;
          }
        }
      }
    }
  }

  // Convert Delta to HTML
  final converter = QuillDeltaToHtmlConverter(
    delta,
    ConverterOptions.forEmail(), // Customize options as per your need
  );

  final html = converter.convert();
  nkDevLog("HTML CODEEEE \n$html");

  // If the HTML is just an empty line, return null
  if (html == "<p><br/></p>") {
    return null;
  }

  // Log the HTML
  nkDevLog("Generated HTML: $html");

  return html;
}

Future<String?> uploadImage(String localImagePath) async {
  try {
    return ApiWorker()
        .uploadFile(
            file: NKMultipart.getMultipartStringFile(file: localImagePath),
            uploadType: "Quiz")
        .then(
      (value) {
        if (value != null && value.data != null && value.status == true) {
          return value.data!.fileUrl;
        } else {
          return localImagePath;
        }
      },
    );
  } catch (e) {
    nkDevLog("Error uploading image: $e");
    return null;
  }
}

Delta? htmlToQuillDelta(String? html) {
  if (html == null || html == "") {
    return null;
  }
  final converter = HtmlToDelta().convert(html);

  return converter;
}

String? htmlToStringText(String? html) {
  if (html == null || html == "") {
    return null;
  }

  var doc = parse(
    html,
  );

  return doc.body?.text;
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
      sliderTheme:  const SliderThemeData(
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
      dialogTheme:  const DialogTheme(
          iconColor: primaryIconColor,
          backgroundColor: primaryColor,
          surfaceTintColor: primaryColor,
          contentTextStyle: TextStyle(color: primaryTextColor),
          titleTextStyle: TextStyle(color: primaryTextColor)),
      checkboxTheme:  const CheckboxThemeData(
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
          dialogTheme:  const quill.QuillDialogTheme(
            dialogBackgroundColor: primaryColor,
            isWrappable: true,
            buttonTextStyle: TextStyle(color: primaryTextColor),
          ),
          embedButtons: FlutterQuillEmbeds.toolbarButtons(
              imageButtonOptions: QuillToolbarImageButtonOptions(
                  imageButtonConfigurations: QuillToolbarImageConfigurations(
                    onRequestPickImage: (context, imagePickerService) async {
                      return await imagePickerService
                          .pickImage(
                              source: $IMG.ImageSource.gallery,
                              maxHeight: 500,
                              maxWidth: 500)
                          .then(
                            (value) => value?.path,
                          );
                    },
                  ),
                  dialogTheme:  const quill.QuillDialogTheme(
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
