// import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
// import 'package:quill_html_editor/quill_html_editor.dart';

// class NkHtmlEditor extends StatefulWidget {
//   final ScrollController scrollController;
//   final QuillEditorController controller;
//   const NkHtmlEditor(
//       {super.key, required this.scrollController, required this.controller});

//   @override
//   State<NkHtmlEditor> createState() => _NkHtmlEditorState();
// }

// class _NkHtmlEditorState extends State<NkHtmlEditor> {
//   @override
//   void initState() {
//     widget.controller.enableEditor(true);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return htmlEditor();
//   }

//   Widget htmlEditor() {
//     return Column(
//       children: [
//         ToolBar(
//           toolBarConfig: const [
//             ToolBarStyle.bold,
//             ToolBarStyle.italic,
//             ToolBarStyle.underline,
//             ToolBarStyle.separator,
//             ToolBarStyle.background,
//             ToolBarStyle.color,
//             ToolBarStyle.size,
//             ToolBarStyle.align,
//             ToolBarStyle.separator,
//             ToolBarStyle.undo,
//             ToolBarStyle.redo,
//             ToolBarStyle.separator,
//             ToolBarStyle.link,
//             ToolBarStyle.image,
//             ToolBarStyle.separator,
//             ToolBarStyle.listBullet,
//             ToolBarStyle.listOrdered,
//             ToolBarStyle.codeBlock,
//             ToolBarStyle.separator,
//             ToolBarStyle.indentAdd,
//             ToolBarStyle.indentMinus,
//           ],
//           activeIconColor: selectionColor,
//           controller: widget.controller,
//           clipBehavior: Clip.antiAlias,
//         ),
//         ConstrainedBox(
//           constraints: BoxConstraints.tight(
//             Size(double.maxFinite, context.height * 0.1),
//           ),
//           child: MyCommnonContainer(
//             border: Border.all(color: primaryTextFieldColor, width: 1),
//             child: QuillHtmlEditor(
//               text: "Notteeeee",
//               hintText: 'Write your notes here...',
//               controller: widget.controller,

//               // ensureVisible: true,
//               minHeight: double.maxFinite,

//               autoFocus: false,

//               textStyle: TextStyle(
//                 fontSize: NkFontSize.regularFont,
//                 color: primaryTextColor,
//                 fontWeight: FontWeight.normal,
//               ),
//               hintTextStyle: TextStyle(
//                   fontSize: NkFontSize.regularFont,
//                   color: textFieldHintTextColor,
//                   fontWeight: FontWeight.normal),
//               hintTextAlign: TextAlign.start,
//               //padding: 5.onlyLeft.copyWith(top: 2),
//               hintTextPadding: 5.onlyLeft.copyWith(top: 2),
//               backgroundColor: primaryColor,
//               inputAction: InputAction.newline,
//               padding: nkRegularPadding,
//               onEditingComplete: (s) => debugPrint('Editing completed $s'),

//               loadingBuilder: (context) {
//                 return 0.space;
//               },

//               onTextChanged: (text) => debugPrint('widget text change $text'),
//               onEditorCreated: () {
//                 debugPrint('Editor has been loaded');
//                 // setHtmlText('Testing text on load');
//               },
//               onEditorResized: (height) => debugPrint('Editor resized $height'),
//               onSelectionChanged: (sel) =>
//                   debugPrint('index ${sel.index}, range ${sel.length}'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   ///[getHtmlText] to get the html text from editor
//   Future<String?> getHtmlText() async {
//     String? htmlText = await widget.controller.getText();
//     debugPrint(htmlText);

//     return htmlText;
//   }

//   ///[setHtmlText] to set the html text to editor
//   void setHtmlText(String text) async {
//     await widget.controller.setText(text);
//   }

//   ///[insertNetworkImage] to set the html text to editor
//   void insertNetworkImage(String url) async {
//     await widget.controller.embedImage(url);
//   }

//   ///[insertVideoURL] to set the video url to editor
//   ///this method recognises the inserted url and sanitize to make it embeddable url
//   ///eg: converts youtube video to embed video, same for vimeo
//   void insertVideoURL(String url) async {
//     await widget.controller.embedVideo(url);
//   }

//   /// to set the html text to editor
//   /// if index is not set, it will be inserted at the cursor postion
//   void insertHtmlText(String text, {int? index}) async {
//     await widget.controller.insertText(text, index: index);
//   }

//   /// to clear the editor
//   void clearEditor() => widget.controller.clear();

//   /// to enable/disable the editor
//   void enableEditor(bool enable) => widget.controller.enableEditor(enable);

//   /// method to un focus editor
//   void unFocusEditor() => widget.controller.unFocus();
// }

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkHtmlEditor extends StatefulWidget {
  final ScrollController scrollController;
  const NkHtmlEditor({super.key, required this.scrollController});

  @override
  State<NkHtmlEditor> createState() => _NkHtmlEditorState();
}

class _NkHtmlEditorState extends State<NkHtmlEditor> {
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return htmlEditor();
  }

  Widget htmlEditor() {
    return Column(
      children: [
        // HtmlToolbar(
        //   controller: controller,
        //   toolbarPosition: ToolbarPosition.aboveEditor,
        //   toolbarType: ToolbarType.nativeGrid,
        //   onButtonPressed: (type, status, updateStatus) {
        //     debugPrint("Button pressed: $type, Status: $status");
        //     return true;
        //   },
        //   onDropdownChanged: (type, changed, updateSelectedItem) {
        //     debugPrint("Dropdown changed: $type, Selected: $changed");
        //     return true;
        //   },
        //   mediaLinkInsertInterceptor: (String url, InsertFileType type) {
        //     debugPrint("Link inserted: $url, type: $type");
        //     return true;
        //   },
        // ),
        SizedBox(
          height: 400,
          width: double.maxFinite,
          child: Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: primaryColor,
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                foregroundColor: primaryTextColor,
                textStyle: TextStyle(color: primaryTextColor),
              )),
              dialogTheme: const DialogTheme(
                  iconColor: primaryIconColor,
                  backgroundColor: primaryColor,
                  surfaceTintColor: primaryColor,
                  contentTextStyle: TextStyle(color: primaryTextColor),
                  titleTextStyle: TextStyle(color: primaryTextColor)),
            ),
            child: HtmlEditor(
              controller: controller,
              htmlEditorOptions: const HtmlEditorOptions(
                hint: "Your text here...",
                initialText: "Initial content...",
                shouldEnsureVisible: true,
              ),
              htmlToolbarOptions: const HtmlToolbarOptions(
                buttonColor: primaryIconColor,
                buttonFillColor: primaryIconColor,

                toolbarType: ToolbarType.nativeGrid,
                toolbarPosition: ToolbarPosition.aboveEditor,
                dropdownBackgroundColor: primaryColor,
                renderBorder: true, // or ToolbarPosition.belowEditor
                defaultToolbarButtons: [
                  FontButtons(),
                  ParagraphButtons(),
                  InsertButtons(
                    link: true,
                    picture: true,
                    video: true,
                    audio: false,
                  ),
                  ListButtons(),
                  StyleButtons(),
                  ColorButtons(),
                  OtherButtons(fullscreen: false, help: false)
                ],
              ),
              otherOptions: const OtherOptions(
                decoration: BoxDecoration(color: secondaryColor),
                height: 100,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Method to get the HTML content from the editor
  Future<String?> getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
    return htmlText;
  }

  /// Method to set the HTML content in the editor
  void setHtmlText(String text) async {
    controller.setText(text);
  }

  /// Method to insert a network image
  void insertNetworkImage(String url) async {
    controller.insertNetworkImage(url);
  }

  /// Method to insert a video URL
  void insertVideoURL(String url) async {
    //  controller.insertLink(url);
  }

  /// Method to insert custom HTML text
  void insertHtmlText(String text) async {
    controller.insertHtml(text);
  }

  /// Method to clear the editor content
  void clearEditor() {
    controller.clear();
  }

  /// Method to enable or disable the editor
  void enableEditor(bool enable) {
    controller.enable();
  }

  /// Method to remove focus from the editor
  void unFocusEditor() {
    controller.clearFocus();
  }
}
