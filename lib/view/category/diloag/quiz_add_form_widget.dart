import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/html_editor/nk_quill_editor.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_number_counter/nk_number_counter_field.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/theme/font_style.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/add_category_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/question_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_add_editor_model.dart';
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

  DataHandler<List<QuestionTypeData>> questionTypeDataHandler = DataHandler();
  bool isCreateQuestion = true;
  @override
  void initState() {
    questionTypeDataHandler.startLoading();
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
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth:
                    context.isMobile ? context.width : context.width * 0.45),
            child: _body(context),
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
              const MyRegularText(label: titleStr),
              _quizTitle(quizAddEditorModelList.first),
              const MyRegularText(label: subTitleStr),
              _quizSubTitle(quizAddEditorModelList[1]),
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
              ] else ...[
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          isCreateQuestion = true;
                        });
                      },
                      label: const MyRegularText(label: editStr),
                      icon: const Icon(
                        Icons.edit,
                        color: primaryIconColor,
                      )),
                )
              ],
            ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
          ),
        ),
        nkSmallSizedBox,
        _QuestionListWidget(
          questionTypeList: questionTypeDataHandler.data ?? [],
          questionList: questionList,
          onQuestionChanged: (quillController) {
            setState(() {
              focusedController = quillController;
            });
          },
        ),
        nkSmallSizedBox,
        if (!isCreateQuestion) ...[
          Align(
            alignment: Alignment.bottomRight,
            child: FittedBox(
              child: MyThemeButton(
                padding: 10.horizontal,
                leadingIcon: const Icon(
                  Icons.add,
                  color: secondaryIconColor,
                ),
                buttonText: "$addStr $questionStr",
                onPressed: onAddQuestion,
              ),
            ),
          )
        ]
      ],
    );
  }

  onCreateExam() {
    setState(() {
      isCreateQuestion = false;
    });
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
        editorKey: quizAddEditorModel.editorKey,
        controller: quizAddEditorModel.controller,
        isReaDOnly: !isCreateQuestion,
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
        isReaDOnly: !isCreateQuestion,
      ),
    );
  }
}

class _QuestionListWidget extends StatefulWidget {
  final List<QuizAddQustionEditorModel> questionList;
  final List<QuestionTypeData> questionTypeList;
  final Function(QuillController? quillController)? onQuestionChanged;
  const _QuestionListWidget(
      {required this.questionList,
      this.onQuestionChanged,
      required this.questionTypeList});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _questionMarks(quizAddQustionEditorModel),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _showQuestionType(quizAddQustionEditorModel, index),
                  _showOtherOption(quizAddQustionEditorModel, index),
                ],
              ),
            ],
          ),
          _questionTitle(quizAddQustionEditorModel.questionController, index),
          _optionList(quizAddQustionEditorModel, index),
        ].addSpaceEveryWidget(space: 5.space),
      ),
    );
  }

  Widget _questionMarks(QuizAddQustionEditorModel quizAddQustionEditorModel) {
    return SizedBox(
      width: 60,
      child: MyFormField(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        textAlign: TextAlign.center,
        autofillHints: const [],
        controller: TextEditingController(),
        labelText: marksStr,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        textInputType: const TextInputType.numberWithOptions(signed: false),
      ),
    );
  }

  Widget _showOtherOption(
      QuizAddQustionEditorModel quizAddQustionEditorModel, int index) {
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton(itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              setState(() {
                questionList.removeAt(index);
              });
            },
            child: const MyRegularText(
              label: removeStr,
              color: errorColor,
            ),
          ),
        ];
      }),
    );
  }

  Widget _showQuestionType(
      QuizAddQustionEditorModel quizAddQustionEditorModel, int index) {
    return NkSearchableDropDownMenu<QuestionTypeData>(
        enableSearch: false,
        initialSelection: quizAddQustionEditorModel.questionType,
        hintText: "$questionStr $typeStr",
        onSelected: (value) {
          if (value != null) {
            setState(() {
              quizAddQustionEditorModel.options = null;
              quizAddQustionEditorModel.questionType = value;
            });
          }
        },
        dropdownMenuEntries: List.generate(
          widget.questionTypeList.length,
          (index) {
            QuestionTypeData questionType = widget.questionTypeList[index];
            return DropdownMenuEntry(
              style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                NkGetXFontStyle.primaryTextTheme(context)
                    .labelMedium
                    ?.copyWith(fontSize: 14),
              )),
              value: questionType,
              labelWidget: MyRegularText(
                label: questionType.name ?? "",
                align: TextAlign.start,
              ),
              label: questionType.name ?? "",
            );
          },
        ).toList());
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

  Widget _optionList(
      QuizAddQustionEditorModel quizAddQustionEditorModel, int perentIndex) {
    if (quizAddQustionEditorModel.options != null &&
        quizAddQustionEditorModel.options?.isNotEmpty == true) {
      return Column(
        children: [
          Column(
            children: List.generate(
              quizAddQustionEditorModel.options?.length ?? 0,
              (index) {
                return _optionWidget(quizAddQustionEditorModel.options![index],
                    perentIndex, index);
              },
            ),
          ),
          if (stringToQuestionENUM(
                  quizAddQustionEditorModel.questionType?.name) ==
              QuestionENUM.multiple) ...[
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                  style: const ButtonStyle(
                    iconColor: WidgetStatePropertyAll(primaryIconColor),
                  ),
                  onPressed: () {
                    onAddOption(quizAddQustionEditorModel);
                  },
                  label: MyRegularText(
                    label: "$addStr $optionStr",
                    fontSize: NkFontSize.smallFont,
                  ),
                  icon: const Icon(
                    Icons.add,
                    color: primaryIconColor,
                  )),
            ),
          ],
          nkExtraSmallSizedBox,
          if (quizAddQustionEditorModel.ansOption != null) ...[
            _answerWidget(
                quizAddQustionEditorModel.ansOption!.optionController),
            nkExtraSmallSizedBox,
            _descriptionWidget(quizAddQustionEditorModel),
            nkExtraSmallSizedBox,
          ],
          _durationWidget(),
        ],
      );
    } else {
      return TextButton.icon(
          style: const ButtonStyle(
            iconColor: WidgetStatePropertyAll(primaryIconColor),
          ),
          onPressed: () {
            if (stringToQuestionENUM(
                    quizAddQustionEditorModel.questionType?.name) ==
                QuestionENUM.multiple) {
              onAddOption(quizAddQustionEditorModel);
            } else {
              onAddOption(quizAddQustionEditorModel);
              onAddOption(quizAddQustionEditorModel);
            }
          },
          label: MyRegularText(
            label: "$addStr $optionStr",
            fontSize: NkFontSize.smallFont,
          ),
          icon: const Icon(
            Icons.add,
            color: primaryIconColor,
          ));
    }
  }

  Widget _optionWidget(
      QuizQuestionOptionsEditorModel model, int perentIndex, int index) {
    return CheckboxListTile.adaptive(
      hoverColor: transparent,
      tileColor: transparent,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: 0.all,
      value: questionList[perentIndex].ansOption == model,
      onChanged: (value) {
        setState(() {
          questionList[perentIndex].ansOption = model;
          // currectAnswer = model;
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
      secondary: IconButton(
          onPressed: () {
            setState(() {
              questionList[perentIndex].options?.removeAt(index);
              questionList[perentIndex].ansOption = null;
            });
          },
          icon: const Icon(
            Icons.remove,
            color: errorColor,
          )),
    );
  }

  Widget _answerWidget(QuizAddEditorModel model) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyRegularText(
          label: "$ansStr.",
          fontWeight: NkGeneralSize.nkBoldFontWeight,
        ),
        Flexible(
          child: NkQuillEditor(
            isReaDOnly: true,
            editorKey: model.editorKey,
            border: Border.all(color: transparent),
            controller: model.controller,
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(QuizAddQustionEditorModel model) {
    if (model.description == null) {
      return TextButton.icon(
          style: const ButtonStyle(
            iconColor: WidgetStatePropertyAll(primaryIconColor),
          ),
          onPressed: () {
            setState(() {
              model.description = QuizQuestionOptionsEditorModel(
                  optionController: QuizAddEditorModel(
                      controller: QuillController.basic(),
                      hint: "Enter Description"));

              widget.onQuestionChanged
                  ?.call(model.description!.optionController.controller);
            });
          },
          label: MyRegularText(
            label: "$addStr $descriptionStr",
            fontSize: NkFontSize.smallFont,
          ),
          icon: const Icon(
            Icons.add,
            color: primaryIconColor,
          ));
    } else {
      return Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyRegularText(
            label: "$descriptionStr. ",
            fontWeight: NkGeneralSize.nkBoldFontWeight,
          ),
          Flexible(
            child: NkQuillEditor(
              hint: model.description!.optionController.hint,
              editorKey: model.description!.optionController.editorKey,
              controller: model.description!.optionController.controller,
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  model.description = null;
                  widget.onQuestionChanged?.call(null);
                });
              },
              icon: const Icon(
                Icons.remove,
                color: errorColor,
              ))
        ],
      );
    }
  }

  Widget _durationWidget() {
    return Row(
      children: [
        MyCommnonContainer(
            padding: 4.all,
            color: lightGreyColor,
            child: const NkTimeCounterField()),
      ],
    );
  }
}
