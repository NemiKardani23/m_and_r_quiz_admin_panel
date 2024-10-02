import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/html_editor/nk_html_editor.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/add_category_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

class QuizAddFormWidget extends StatefulWidget {
  final CategoryData? categoryDataModel;
  final Function(CategoryData? catData)? onUpdated;
  final CategoryTypeENUM categoryType;
  final FileTypeData fileTypeModel;
  final String? parentId;
  const QuizAddFormWidget(
      {super.key,
      this.categoryDataModel,
      this.onUpdated,
      required this.categoryType,
      required this.fileTypeModel,
      this.parentId});

  @override
  State<QuizAddFormWidget> createState() => _QuizAddFormWidgetState();
}

class _QuizAddFormWidgetState extends State<QuizAddFormWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: widget.categoryDataModel != null
            ? "$editStr ${widget.fileTypeModel.typeName}"
            : "$addStr ${widget.fileTypeModel.typeName}",
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth:
                  context.isMobile ? context.width : context.width * 0.35),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        _quizHeading(),
      ],
    );
  }

  Widget _quizHeading() {
    return Column(
      children: [
        const NkPickerWithPlaceHolder(
            fileType: "image", pickType: FileType.image),
        NkHtmlEditor(
          // controller: QuillEditorController(),
          scrollController: scrollController,
        )
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }
}
