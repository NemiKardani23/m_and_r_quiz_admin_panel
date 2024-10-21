import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/html_editor/nk_quill_editor.dart';
import 'package:m_and_r_quiz_admin_panel/components/mouse_hover/nk_hover_change_widget.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/session/null_check_oprations.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';
import 'package:m_and_r_quiz_admin_panel/utills/image_upload/nk_multipart.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/add_category_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/question_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_add_editor_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_create_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/quiz/quiz_question_list_widget.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

enum QuestionENUM { multiple, trueFalse }

extension QuestionExtension on QuestionENUM {
  String get questionType {
    switch (this) {
      case QuestionENUM.multiple:
        return "Multiple Choice";
      case QuestionENUM.trueFalse:
        return "True/False";
      default:
        return "Multiple Choice";
    }
  }
}

QuestionENUM stringToQuestionENUM(String? type) {
  switch (type) {
    case "Multiple Choice":
      return QuestionENUM.multiple;
    case "True/False":
      return QuestionENUM.trueFalse;
    default:
      return QuestionENUM.multiple;
  }
}

class QuizAddFormWidget extends StatefulWidget {
  final CategoryData? categoryDataModel;
  final Function(CategoryData? catData)? onUpdated;
  final CategoryTypeENUM categoryType;
  final FileTypeData fileTypeModel;
  final String? parentId;
  final QuizCreateData? quizCreateData;
  const QuizAddFormWidget(
      {super.key,
      this.categoryDataModel,
      this.onUpdated,
      required this.categoryType,
      required this.fileTypeModel,
      this.parentId,
      this.quizCreateData});

  @override
  State<QuizAddFormWidget> createState() => _QuizAddFormWidgetState();
}

class _QuizAddFormWidgetState extends State<QuizAddFormWidget> {
  final ScrollController _scrollController = ScrollController();
  List<QuizAddEditorModel> quizAddEditorModelList = [
    QuizAddEditorModel(
        controller: QuillController.basic(editorFocusNode: FocusNode()),
        hint: "Title*"),
    QuizAddEditorModel(
        controller: QuillController.basic(editorFocusNode: FocusNode()),
        hint: "Sub Title"),
  ];
  QuillController? focusedController;

  List<QuizAddQustionEditorModel> questionList = [];

  DataHandler<List<QuestionTypeData>> questionTypeDataHandler = DataHandler();
  bool isCreateQuestion = true;
  bool isCreateExamEditable = false;
  QuizCreateData? quizCreateData;

  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;
  @override
  void initState() {
    questionTypeDataHandler.startLoading();
    loadQuizData();
    TempDataStore.getQuestionTypeList.then(
      (value) {
        setState(() {
          questionTypeDataHandler.onSuccess(value ?? []);
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: transparent,
      alignment: Alignment.center,
      title: Column(
        children: [
          MyCommnonContainer(
            padding: 16.horizontal,
            child: MyAppBar(
              heading: widget.categoryDataModel != null
                  ? "$editStr ${widget.fileTypeModel.typeName}"
                  : "$addStr ${widget.fileTypeModel.typeName}",
            ),
          ),
          10.space,
          if (focusedController != null) ...[
            MyCommnonContainer(
              height: context.isTablet || context.isMobile ? 180 : null,
              width: context.isLargeDesktop
                  ? null
                  : context.isTablet || context.isMobile
                      ? context.width
                      : null,
              padding: 0.all,
              child: NkQuillToolbar(
                controller: focusedController,
              ),
            ),
          ],
        ],
      ),
      content: AlertDialog(
        backgroundColor: transparent,
        contentPadding: 0.all,
        titlePadding: 0.all.copyWith(bottom: nkRegularPadding.bottom),
        content: SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth:
                    context.isMobile ? context.width : context.width * 0.45),
            child: _body(context),
          ),
        ),
        actionsPadding: 10.onlyTop,
        actions: [
          if (_scrollController.hasClients)
            ValueListenableBuilder(
              valueListenable: _scrollController.position.isScrollingNotifier,
              builder: (context, _, __) {
                return _scrollDownButton();
              },
            ),
        ],
      ),
    );
  }

  Widget _scrollDownButton() {
    if (!_scrollController.hasClients) {
      return const SizedBox();
    }

    // Hide the widget entirely when at the top (minScrollExtent)
    bool hideWidget =
        _scrollController.offset == _scrollController.position.minScrollExtent;

    // Show the scroll down button when the user is not at the bottom
    bool showScrollDownButton =
        _scrollController.offset < _scrollController.position.maxScrollExtent;

    if (hideWidget) {
      return const SizedBox(); // Hide the entire widget
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: NkHoverChangeWidget.hoverCrossFadeWidget(
        alignmentry: Alignment.centerRight,
        firstChild: showScrollDownButton
            ? InkWell(
                onTap: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubicEmphasized,
                  );
                },
                child: const Icon(
                    Icons.arrow_downward_rounded), // Filled arrow down
              )
            : InkWell(
                onTap: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubicEmphasized,
                  );
                },
                child:
                    const Icon(Icons.arrow_upward_rounded), // Filled arrow up
              ),
        secondChild: showScrollDownButton
            ? TextButton.icon(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubicEmphasized,
                  );
                },
                icon: const Icon(
                    Icons.arrow_downward_rounded), // Filled arrow down
                label: const MyRegularText(
                  label: scrollDownStr,
                  fontWeight: FontWeight.bold,
                ),
              )
            : TextButton.icon(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubicEmphasized,
                  );
                },
                icon: const Icon(Icons.arrow_upward_rounded), // Filled arrow up
                label: const MyRegularText(
                  label: scrollUpStr,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              const MyRegularText(label: "$titleStr*"),
              _quizTitle(quizAddEditorModelList.first),
              const MyRegularText(label: subTitleStr),
              _quizSubTitle(quizAddEditorModelList[1]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: _questionMarksCount()),
                  _addEditExamButton(),
                ],
              ),
            ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
          ),
        ),
        nkSmallSizedBox,
        questionTypeDataHandler.when(
            context: context,
            successBuilder: (questioTYPELIST) {
              questioTYPELIST.length.$PRINT;
              return QuizQuestionListWidget(
                onTestUpdated: (value) {
                  setState(() {
                    quizCreateData = quizCreateData?.copyWith(
                      totalQuestions: value.updatedTest?.totalQuestions,
                      totalMarks: value.updatedTest?.totalMarks.toString(),
                      totalDuration: value.updatedTest?.totalDuration,
                    );
                  });
                },
                quizCreateData: quizCreateData,
                questionTypeList: questioTYPELIST,
                questionList: questionList,
                onQuestionChanged: (quillController) {
                  setState(() {
                    focusedController = quillController;
                  });
                },
              );
            }),
        nkSmallSizedBox,
        // if (!isCreateQuestion &&
        //     !isCreateExamEditable &&
        //     quizCreateData != null) ...[
        //   Align(
        //     alignment: Alignment.bottomRight,
        //     child: FittedBox(
        //       child: MyThemeButton(
        //         padding: 10.horizontal,
        //         leadingIcon: const Icon(
        //           Icons.add,
        //           color: secondaryIconColor,
        //         ),
        //         buttonText: "$addStr $questionStr",
        //         onPressed: onAddQuestion,
        //       ),
        //     ),
        //   )
        // ] else if (isCreateQuestion && quizCreateData != null)
        //   ...[]
      ],
    );
  }

  Widget _addEditExamButton() {
    return Column(
      children: [
        if (isCreateQuestion) ...[
          Align(
            alignment: Alignment.bottomRight,
            child: FittedBox(
              child: MyThemeButton(
                padding: 10.horizontal,
                leadingIcon: const Icon(
                  Icons.add,
                  color: secondaryIconColor,
                ),
                buttonText: "$createStr $examStr",
                onPressed: onCreateExam,
              ),
            ),
          )
        ] else if (isCreateExamEditable && quizCreateData != null) ...[
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreateExamEditable = false;
                    });
                  },
                  child: const MyRegularText(
                    label: cancleStr,
                    color: errorColor,
                  ),
                ),
                FittedBox(
                  child: MyThemeButton(
                    padding: 10.horizontal,
                    leadingIcon: const Icon(
                      Icons.add,
                      color: secondaryIconColor,
                    ),
                    buttonText: "$updateStr $examStr",
                    onPressed: onUpdateQuiz,
                  ),
                )
              ].addSpaceEveryWidget(space: 5.space),
            ),
          )
        ] else if (!isCreateExamEditable && quizCreateData != null) ...[
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton.icon(
                onPressed: onEditQuiz,
                label: const MyRegularText(label: editStr),
                icon: const Icon(
                  Icons.edit,
                  color: primaryIconColor,
                )),
          )
        ],
      ],
    );
  }

  Widget _questionMarksCount() {
    if (quizCreateData == null) {
      return const SizedBox.shrink();
    }
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 5,
      runSpacing: 5,
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      children: [
        MyCommnonContainer(
          padding: 6.all,
          isCardView: true,
          child: MyRegularText(
            label:
                "$totalStr $questionStr : ${quizCreateData?.totalQuestions ?? "0"} ",
          ),
        ),
        MyCommnonContainer(
          padding: 6.all,
          isCardView: true,
          child: MyRegularText(
            label:
                "$totalStr $marksStr : ${quizCreateData?.totalMarks ?? "0"} ",
          ),
        ),
        MyCommnonContainer(
          padding: 6.all,
          isCardView: true,
          child: MyRegularText(
            label:
                "$totalStr $durationStr : ${NKDateUtils.formatDurationHHMMSS(Duration(seconds: quizCreateData?.totalDuration?.toInt() ?? 0))} ",
          ),
        ),
      ],
    );
  }

  loadQuizData() {
    if (widget.quizCreateData != null) {
      nkDevLog("QIZ DATA : ${widget.quizCreateData}");
      setState(() {
        quizCreateData = widget.quizCreateData!;
        quizAddEditorModelList.first.controller
            .setContents(htmlToQuillDelta(quizCreateData?.title!)!);
        if (quizCreateData?.description != null) {
          quizAddEditorModelList.last.controller
              .setContents(htmlToQuillDelta(quizCreateData?.description!)!);
        }
        isCreateExamEditable = false;
        isCreateQuestion = false;
      });
    }
  }

  onCreateExam() {
    var titleData = quizAddEditorModelList.first.controller;
    var description = quizAddEditorModelList.last.controller;
    nkDevLog("Plaintext : ${titleData.plainTextEditingValue.text}");
    nkDevLog("PlainDES : ${description.plainTextEditingValue.text}");
    if (CheckNullData.checkNullOrEmptyString(
        titleData.plainTextEditingValue.text.toString())) {
      NKToast.error(title: "Title can't be empty");
      return;
    } else if (CheckNullData.checkNullOrEmptyString(
        description.plainTextEditingValue.text.toString())) {
      var convertedTitle =
          quillDeltaToHtml(titleData.document.toDelta().toJson());
      ApiWorker()
          .createQuiz(
        fileTypeId: widget.fileTypeModel.id.toString(),
        title: convertedTitle!,
        categoryId: widget.parentId!,
      )
          .then((value) {
        if (value != null) {
          setState(() {
            quizCreateData = value;
            isCreateQuestion = false;
            quizAddEditorModelList.first.controller
                .setContents(htmlToQuillDelta(value.title!)!);
            if (value.description != null) {
              quizAddEditorModelList.last.controller
                  .setContents(htmlToQuillDelta(value.description!)!);
            }
          });
        }
      });
      return;
    } else {
      var convertedTitle =
          quillDeltaToHtml(titleData.document.toDelta().toJson());
      var convertedDescription =
          quillDeltaToHtml(description.document.toDelta().toJson());
      ApiWorker()
          .createQuiz(
              fileTypeId: widget.fileTypeModel.id.toString(),
              title: convertedTitle!,
              categoryId: widget.parentId!,
              description: convertedDescription)
          .then((value) {
        if (value != null) {
          setState(() {
            quizCreateData = value;
            isCreateQuestion = false;
            quizAddEditorModelList.first.controller
                .setContents(htmlToQuillDelta(value.title!)!);
            if (value.description != null) {
              quizAddEditorModelList.last.controller
                  .setContents(htmlToQuillDelta(value.description!)!);
            }
          });
        }
      });
    }
  }

  onEditQuiz() {
    setState(() {
      isCreateExamEditable = true;
    });
  }

  onUpdateQuiz() {
    var titleData = quizAddEditorModelList.first.controller;
    var description = quizAddEditorModelList.last.controller;
    nkDevLog("Plaintext : ${titleData.plainTextEditingValue.text}");
    nkDevLog("PlainDES : ${description.plainTextEditingValue.text}");
    var convertedTitle =
        quillDeltaToHtml(titleData.document.toDelta().toJson());
    var convertedDescription =
        quillDeltaToHtml(description.document.toDelta().toJson());
    ApiWorker()
        .updateQuiz(
      quizId: quizCreateData!.testId.toString(),
      title: convertedTitle!,
      description: convertedDescription,
      thumbnail: NKMultipart.getMultipartImageBytesNullable(
          name: onImagePicked?.$2 ?? "", imageBytes: onImagePicked?.$1),
      categoryId: widget.parentId!,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          quizCreateData = value;
          isCreateExamEditable = false;
          quizAddEditorModelList.first.controller
              .setContents(htmlToQuillDelta(value.title!)!);
          if (value.description != null) {
            quizAddEditorModelList.last.controller
                .setContents(htmlToQuillDelta(value.description!)!);
          }
        });
      }
    });
    return;

    // setState(() {
    //   isCreateQuestion = true;
    // });
  }

  Widget _examThumbnail() {
    return NkPickerWithPlaceHolder(
      fileType: "image",
      imageUrl: quizCreateData?.thumbnail,
      pickType: FileType.image,
      lableText: headingImageStr,
      onFilePicked: (imageBytes, imageName) {},
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
        editorKey: quizAddEditorModel.editorKey,
        controller: quizAddEditorModel.controller,
        isReaDOnly: !isCreateQuestion && !isCreateExamEditable,
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
        editorKey: quizAddEditorModel.editorKey,
        controller: quizAddEditorModel.controller,
        isReaDOnly: !isCreateQuestion && !isCreateExamEditable,
      ),
    );
  }
}
