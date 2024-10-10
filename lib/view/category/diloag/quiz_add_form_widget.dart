import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/html_editor/nk_quill_editor.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/add_category_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_add_editor_model.dart';
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
  final List<QuizAddEditorModel> quizAddEditorModelList = [
    QuizAddEditorModel(
        controller: QuillController.basic(editorFocusNode: FocusNode()),
        hint: "Title"),
    QuizAddEditorModel(
        controller: QuillController.basic(editorFocusNode: FocusNode()),
        hint: "Sub Title"),
  ];
  QuillController? focusedController;

  List<QuizAddQustionEditorModel> questionList = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: transparent,
      child: Flex(
        //alignment: WrapAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // runAlignment: WrapAlignment.center,
        direction: context.isTablet || context.isMobile
            ? Axis.vertical
            : Axis.horizontal,
        children: [
          Flexible(
            child: AlertDialog(
              backgroundColor: transparent,
              contentPadding: 0.all,
              titlePadding: 0.all.copyWith(bottom: nkRegularPadding.bottom),
              title: MyCommnonContainer(
                padding: 16.horizontal,
                child: MyAppBar(
                  heading: widget.categoryDataModel != null
                      ? "$editStr ${widget.fileTypeModel.typeName}"
                      : "$addStr ${widget.fileTypeModel.typeName}",
                ),
              ),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: context.isMobile
                          ? context.width
                          : context.width * 0.35),
                  child: _body(context),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (focusedController != null) ...[
                MyCommnonContainer(
                  height: context.isTablet || context.isMobile ? 180 : 180,
                  width: context.isLargeDesktop
                      ? context.width / 5.0
                      : context.isTablet || context.isMobile
                          ? context.width
                          : context.width / 2.6,
                  padding: 0.all,
                  child: NkQuillToolbar(
                    controller: focusedController,
                  ),
                ),
              ],
              MyThemeButton(
                padding: 10.horizontal,
                leadingIcon: const Icon(
                  Icons.add,
                  color: secondaryIconColor,
                ),
                buttonText: "$addStr $questionStr",
                onPressed: onAddQuestion,
              )
            ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
          )
          // AlertDialog(
          //   elevation: NkGeneralSize.nkCommoElevation,
          //   backgroundColor: primaryColor,
          //   contentPadding: 0.all,
          //   titlePadding: 0.all,
          //   insetPadding: 0.all,
          //   content: ConstrainedBox(
          //     constraints: BoxConstraints(
          //         maxWidth: 20,
          //         minWidth: context.isMobile ? context.width : 10),
          //     child: NkQuillToolbar(
          //       controller:
          //           quizAddEditorModelList[focusedWidgetIndex].controller,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        MyCommnonContainer(
          padding: nkRegularPadding.copyWith(
            top: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _examThumbnail()),
              const MyRegularText(label: titleStr),
              _quizTitle(quizAddEditorModelList.first),
              const MyRegularText(label: subTitleStr),
              _quizSubTitle(quizAddEditorModelList[1]),
            ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
          ),
        ),
        nkSmallSizedBox,
        _QuestionListWidget(
          questionList: questionList,
          onQuestionChanged: (quillController) {
            setState(() {
              focusedController = quillController;
            });
          },
        )
      ],
    );
  }

  onAddQuestion() {
    setState(() {
      questionList.add(
        QuizAddQustionEditorModel(
          questionController: QuizAddEditorModel(
            hint: "Question",
            controller: QuillController.basic(editorFocusNode: FocusNode()),
          ),
        ),
      );
    });
  }

  Widget _examThumbnail() {
    return const NkPickerWithPlaceHolder(
      fileType: "image",
      pickType: FileType.image,
      lableText: headingImageStr,
    );
  }

  Widget _quizTitle(QuizAddEditorModel quizAddEditorModel) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        setState(() {
          focusedController = quizAddEditorModel.controller;
        });

        // quizAddEditorModel.controller.editorFocusNode?.requestFocus();

        nkDevLog("FOCUSED WIDGET : $focusedController");
      },
      child: NkQuillEditor(
        unSelect: (unSelected) {
          setState(() {
            focusedController = null;
          });
        },
        isSelected: focusedController == quizAddEditorModel.controller,
        hint: quizAddEditorModel.hint,
        controller: quizAddEditorModel.controller,
        // controller: QuillEditorController(),
      ),
    );
  }

  Widget _quizSubTitle(QuizAddEditorModel quizAddEditorModel) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        setState(() {
          focusedController = quizAddEditorModel.controller;
        });

        nkDevLog("FOCUSED WIDGET : $focusedController");
      },
      child: NkQuillEditor(
        unSelect: (unSelected) {
          setState(() {
            focusedController = null;
          });
        },
        isSelected: focusedController == quizAddEditorModel.controller,
        hint: quizAddEditorModel.hint,
        controller: quizAddEditorModel.controller,
      ),
    );
  }
}

class _QuestionListWidget extends StatefulWidget {
  final List<QuizAddQustionEditorModel> questionList;
  final Function(QuillController? quillController)? onQuestionChanged;
  const _QuestionListWidget(
      {required this.questionList, this.onQuestionChanged});

  @override
  State<_QuestionListWidget> createState() => _QuestionListWidgetState();
}

class _QuestionListWidgetState extends State<_QuestionListWidget> {
  List<QuizAddQustionEditorModel> questionList = [];
  QuizQuestionOptionsEditorModel? currectAnswer;

  @override
  void initState() {
    questionList = widget.questionList;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _QuestionListWidget oldWidget) {
    questionList = widget.questionList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(questionList.length, (index) {
        return questionListWidget(context, index, questionList[index]);
      }).addSpaceEveryWidget(space: 10.space),
    );
  }

  onAddOption(QuizAddQustionEditorModel question) {
    question.options ??= [];
    setState(() {
      question.options?.add(
        QuizQuestionOptionsEditorModel(
          optionController: QuizAddEditorModel(
            hint: "Option",
            controller: QuillController.basic(editorFocusNode: FocusNode()),
          ),
        ),
      );
    });
  }

  Widget questionListWidget(BuildContext context, int index,
      QuizAddQustionEditorModel quizAddQustionEditorModel) {
    return MyCommnonContainer(
      padding: 10.all,
      child: Column(
        children: [
          _questionTitle(quizAddQustionEditorModel.questionController, index),
          _optionList(quizAddQustionEditorModel),
        ].addSpaceEveryWidget(space: 5.space),
      ),
    );
  }

  Widget _questionTitle(QuizAddEditorModel quizAddEditorModel, int index) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        widget.onQuestionChanged?.call(quizAddEditorModel.controller);
      },
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: 0.all,
        leading: MyRegularText(
          label: "${index + 1}.",
        ),
        title: NkQuillEditor(
          border: const Border(bottom: BorderSide(color: textFieldBorderColor)),
          hint: quizAddEditorModel.hint,
          controller: quizAddEditorModel.controller,
          // controller: QuillEditorController(),
        ),
      ),
    );
  }

  Widget _optionList(QuizAddQustionEditorModel quizAddQustionEditorModel) {
    if (quizAddQustionEditorModel.options != null &&
        quizAddQustionEditorModel.options?.isNotEmpty == true) {
      return Column(
        children: [
          Column(
            children: List.generate(
              quizAddQustionEditorModel.options?.length ?? 0,
              (index) {
                return _optionWidget(quizAddQustionEditorModel.options![index]);
              },
            ),
          ),
          TextButton.icon(
              onPressed: () {
                onAddOption(quizAddQustionEditorModel);
              },
              label: const MyRegularText(label: "$addStr $optionStr"),
              icon: const Icon(Icons.add))
        ],
      );
    } else {
      return TextButton.icon(
          onPressed: () {
            onAddOption(quizAddQustionEditorModel);
          },
          label: const MyRegularText(label: "$addStr $optionStr"),
          icon: const Icon(Icons.add));
    }
  }

  Widget _optionWidget(QuizQuestionOptionsEditorModel model) {
    return CheckboxListTile.adaptive(
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: 0.all,
      value: currectAnswer == model,
      onChanged: (value) {
        setState(() {
          currectAnswer = model;
        });
      },
      title: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          widget.onQuestionChanged?.call(model.optionController.controller);
        },
        child: NkQuillEditor(
          border: const Border(bottom: BorderSide(color: textFieldBorderColor)),
          hint: model.optionController.hint,
          controller: model.optionController.controller,
          // controller: QuillEditorController(),
        ),
      ),
    );
  }
}
