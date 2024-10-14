// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

// class NkHtmlEditor extends StatefulWidget {
//   final HtmlEditorController? controller;
//   final double height;
//   final double width;
//   final String? hint;
//   const NkHtmlEditor(
//       {super.key,
//       this.controller,
//       this.height = 200,
//       this.width = 400,
//       this.hint});

//   @override
//   State<NkHtmlEditor> createState() => _NkHtmlEditorState();
// }

// class _NkHtmlEditorState extends State<NkHtmlEditor> {
//   late HtmlEditorController controller;

//   @override
//   void initState() {
//     controller = widget.controller ?? HtmlEditorController();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return htmlEditor();
//   }

//   Widget htmlEditor() {
//     return TapRegion(
//       behavior: HitTestBehavior.translucent,
//       onTapOutside: (event) {
//         FocusManager.instance.primaryFocus?.unfocus();
//         // controller.clearFocus();
//       },
//       onTapInside: (event) {
//         controller.setFocus();
//       },
//       child: Column(
//         children: [
//           MyCommnonContainer(
//             borderRadiusGeometry: BorderRadius.circular(2),
//             height: widget.height,
//             elevation: 3,
//             isCardView: true,
//             width: widget.width,
//             child: Theme(
//               data: Theme.of(context).copyWith(
//                 dialogBackgroundColor: primaryColor,
//                 textButtonTheme: TextButtonThemeData(
//                     style: TextButton.styleFrom(
//                   foregroundColor: primaryTextColor,
//                   textStyle: const TextStyle(color: primaryTextColor),
//                 )),
//                 dialogTheme: const DialogTheme(
//                     iconColor: primaryIconColor,
//                     backgroundColor: primaryColor,
//                     surfaceTintColor: primaryColor,
//                     contentTextStyle: TextStyle(color: primaryTextColor),
//                     titleTextStyle: TextStyle(color: primaryTextColor)),
//               ),
//               child: HtmlEditor(
//                 controller: controller,
//                 htmlEditorOptions: HtmlEditorOptions(
//                   hint: widget.hint ?? "Your text here...",
//                   // initialText: "Initial content...",
//                   shouldEnsureVisible: true,
//                 ),
//                 htmlToolbarOptions: const HtmlToolbarOptions(
//                   buttonColor: primaryIconColor,

//                   buttonFillColor: primaryIconColor,

//                   toolbarType: ToolbarType.nativeExpandable,
//                   toolbarPosition: ToolbarPosition.custom,

//                   dropdownBackgroundColor: primaryColor,
//                   renderBorder: true, // or ToolbarPosition.belowEditor
//                   defaultToolbarButtons: [
//                     FontButtons(),
//                     ParagraphButtons(),
//                     InsertButtons(
//                       link: true,
//                       picture: true,
//                       video: true,
//                       audio: false,
//                     ),
//                     ListButtons(),
//                     StyleButtons(),
//                     ColorButtons(),
//                     OtherButtons(fullscreen: false, help: false)
//                   ],
//                 ),
//                 otherOptions: OtherOptions(
//                   decoration: BoxDecoration(
//                       color: secondaryColor,
//                       border:
//                           Border.all(color: textFieldBorderColor, width: 1)),
//                   height: widget.height,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: context.width / 2,
//             height: 40,
//             child: ToolbarWidget(
//               controller: controller,
//               htmlToolbarOptions: const HtmlToolbarOptions(
//                 buttonColor: primaryIconColor,
//                 buttonFillColor: primaryIconColor,
//                 toolbarItemHeight: 40,
//                 dropdownMenuDirection: DropdownMenuDirection.up,
//                 toolbarType: ToolbarType.nativeScrollable,
//                 toolbarPosition: ToolbarPosition.belowEditor,

//                 dropdownBackgroundColor: primaryColor,
//                 renderBorder: true, // or ToolbarPosition.belowEditor
//                 defaultToolbarButtons: [
//                   FontButtons(),
//                   ParagraphButtons(),
//                   InsertButtons(
//                     link: true,
//                     picture: true,
//                     video: true,
//                     audio: false,
//                   ),
//                   ListButtons(),
//                   StyleButtons(),
//                   ColorButtons(),
//                   OtherButtons(fullscreen: false, help: false)
//                 ],
//               ),
//               callbacks: null,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   /// Method to get the HTML content from the editor
//   Future<String?> getHtmlText() async {
//     String? htmlText = await controller.getText();
//     debugPrint(htmlText);
//     return htmlText;
//   }

//   /// Method to set the HTML content in the editor
//   void setHtmlText(String text) async {
//     controller.setText(text);
//   }

//   /// Method to insert a network image
//   void insertNetworkImage(String url) async {
//     controller.insertNetworkImage(url);
//   }

//   /// Method to insert a video URL
//   void insertVideoURL(String url) async {
//     //  controller.insertLink(url);
//   }

//   /// Method to insert custom HTML text
//   void insertHtmlText(String text) async {
//     controller.insertHtml(text);
//   }

//   /// Method to clear the editor content
//   void clearEditor() {
//     controller.clear();
//   }

//   /// Method to enable or disable the editor
//   void enableEditor(bool enable) {
//     controller.enable();
//   }

//   /// Method to remove focus from the editor
//   void unFocusEditor() {
//     controller.clearFocus();
//   }
// }
