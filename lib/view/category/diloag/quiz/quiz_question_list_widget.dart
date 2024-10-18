import 'package:flutter_quill/flutter_quill.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/html_editor/nk_quill_editor.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_number_counter/nk_number_counter_field.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/theme/font_style.dart';
import 'package:m_and_r_quiz_admin_panel/utills/datetime/nk_date_utils.dart';
import 'package:m_and_r_quiz_admin_panel/utills/extentions/data_extentions.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/question_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_add_editor_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_create_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_question_response.dart';

import 'package:m_and_r_quiz_admin_panel/view/category/diloag/quiz/quiz_add_form_widget.dart';

class QuizQuestionListWidget extends StatefulWidget {
  final List<QuizAddQustionEditorModel> questionList;
  final List<QuestionTypeData> questionTypeList;
  final Function(QuillController? quillController)? onQuestionChanged;
  final QuizCreateData? quizCreateData;
  final ValueChanged<QuizQuestionData>? onTestUpdated;
  const QuizQuestionListWidget(
      {super.key,
      required this.questionList,
      this.onQuestionChanged,
      required this.questionTypeList,
      this.quizCreateData,
      this.onTestUpdated});

  @override
  State<QuizQuestionListWidget> createState() => _QuizQuestionListWidgetState();
}

class _QuizQuestionListWidgetState extends State<QuizQuestionListWidget> {
  List<QuizAddQustionEditorModel> questionList = [];
  QuizQuestionOptionsEditorModel? currectAnswer;

  DataHandler<List<QuizQuestionData>> qUIZZZDATAHANDLER = DataHandler();

  @override
  void initState() {
    questionList = widget.questionList;
    callApi();
    super.initState();
  }

  void callApi() {
    // Ensure quizCreateData exists and contains a valid testId before making API calls
    if (widget.quizCreateData?.testId != null) {
      // Start loading state
      qUIZZZDATAHANDLER.startLoading();

      // Fetch quiz questions from the API
      ApiWorker()
          .getQuizQuestionList(quizId: widget.quizCreateData!.testId.toString())
          .then((response) {
        // Check if the response is valid and contains data
        if (response != null &&
            response.status == true &&
            response.data.isNotEmpty) {
          // On success, process and map the data to questionList
          qUIZZZDATAHANDLER.onSuccess(response.data);

          // Separate function to process and add questions to the list
          addQuestionsToList(response.data);
        } else {
          // Handle case where response is valid but contains no data
          setState(() {
            qUIZZZDATAHANDLER
                .onError(response?.message ?? ErrorStrings.noDataFound);
          });
        }
      }).catchError((error) {
        // Log and handle any errors that occur during the API call
        nkDevLog("ERROR : $error");
        setState(() {
          qUIZZZDATAHANDLER.onError(ErrorStrings.oopsSomethingWentWrong);
        });
      });
    } else {
      // If quizCreateData is null or doesn't have a valid testId, log an error or handle appropriately
      nkDevLog("Invalid quizCreateData or missing testId");
      setState(() {
        qUIZZZDATAHANDLER.onError(ErrorStrings.oopsSomethingWentWrong);
      });
    }
  }

// New function to map API response and add questions to the list
  void addQuestionsToList(List<QuizQuestionData> apiData) {
    List<QuizAddQustionEditorModel> loadedQuestions = apiData.map((e) {
      // Mapping each API question to QuizAddQustionEditorModel
      return QuizAddQustionEditorModel(
        isEditable: false,
        marks: e.marks,
        isNewData: false,
        ansOption: QuizQuestionOptionsEditorModel(
          optionController: QuizAddEditorModel(
            initalValue: e.correctAnswer,
            controller: QuillController.basic(),
          ),
        ),
        options: e.optionsList.map((op) {
          return QuizQuestionOptionsEditorModel(
            optionController: QuizAddEditorModel(
              initalValue: op,
              controller: QuillController.basic(editorFocusNode: FocusNode()),
            ),
          );
        }).toList(),
        questionController: QuizAddEditorModel(
          hint: "Question",
          initalValue: e.questionText,
          controller: QuillController.basic(editorFocusNode: FocusNode()),
        ),
        initalValue: e.questionText,
        quizData: e,
        questionType: widget.questionTypeList.firstWhereOrNull(
          (element) => element.questionTypeId.toString() == e.questionTypeId,
        ),
        qustionCompletionTime: e.duration?.toDuration,
        description: QuizQuestionOptionsEditorModel(
          optionController: QuizAddEditorModel(
            initalValue: e.answerDescription,
            controller: QuillController.basic(editorFocusNode: FocusNode()),
          ),
        ),
      );
    }).toList();

    // Update state with the newly loaded questions
    setState(() {
      questionList.addAll(loadedQuestions);
    });
  }

  // New function to map API single response and add question to the list
  void addSingleQuestionToList(QuizQuestionData apiData) {
    // Mapping the API question to QuizAddQustionEditorModel
    QuizAddQustionEditorModel loadedQuestion = QuizAddQustionEditorModel(
      isEditable: false,
      marks: apiData.marks,
      isNewData: false,
      ansOption: QuizQuestionOptionsEditorModel(
        optionController: QuizAddEditorModel(
          initalValue: apiData.correctAnswer,
          controller: QuillController.basic(),
        ),
      ),
      options: apiData.optionsList.map((op) {
        return QuizQuestionOptionsEditorModel(
          optionController: QuizAddEditorModel(
            initalValue: op,
            controller: QuillController.basic(editorFocusNode: FocusNode()),
          ),
        );
      }).toList(),
      questionController: QuizAddEditorModel(
        hint: "Question",
        initalValue: apiData.questionText,
        controller: QuillController.basic(editorFocusNode: FocusNode()),
      ),
      initalValue: apiData.questionText,
      quizData: apiData,
      questionType: widget.questionTypeList.firstWhereOrNull(
        (element) =>
            element.questionTypeId.toString() == apiData.questionTypeId,
      ),
      qustionCompletionTime: apiData.duration?.toDuration,
      description: QuizQuestionOptionsEditorModel(
        optionController: QuizAddEditorModel(
          initalValue: apiData.answerDescription,
          controller: QuillController.basic(editorFocusNode: FocusNode()),
        ),
      ),
    );

    // Update state with the newly added question
    setState(() {
      questionList.add(loadedQuestion);
    });
  }

  /// Upload Question To Server
  uploadQuestion(QuizAddQustionEditorModel data) {
    ApiWorker()
        .setQuestion(
            quizId: widget.quizCreateData!.testId.toString(),
            questionTypeId: data.questionType!.questionTypeId.toString(),
            questionText: quillDeltaToHtml(data
                .questionController.controller.document
                .toDelta()
                .toJson())!,
            marks: data.marks!,
            duration: data.qustionCompletionTime!.inSeconds.toString(),
            correctAnswer: quillDeltaToHtml(data
                .ansOption!.optionController.controller.document
                .toDelta()
                .toJson())!,
            answerDescription: quillDeltaToHtml(data
                .description?.optionController.controller.document
                .toDelta()
                .toJson()),
            optionsList: data.options!
                .map((e) => quillDeltaToHtml(
                    e.optionController.controller.document.toDelta().toJson())!)
                .toList())
        .then((value) {
      if (value != null && value.testId != null) {
        for (var element in questionList) {
          if (element.isNewData == true) {
            questionList.remove(element);
          }
        }
        widget.onTestUpdated?.call(value);
        addSingleQuestionToList(value);
      }
    });
  }

  bool validateQuestionField(QuizAddQustionEditorModel data) {
    if (data.marks == null || data.marks?.isNotEmpty == false) {
      NKToast.error(title: "Please Enter Marks");
      return false;
    } else if (data.questionType == null) {
      NKToast.error(title: "Please Select Question Type");
      return false;
    } else if (data.questionController.controller.plainTextEditingValue.text
            .isNotEmpty ==
        false) {
      NKToast.error(title: "Please Enter Question");
      return false;
    } else if (data.options == null || data.options?.isNotEmpty == false) {
      NKToast.error(title: "Please Add Options");
      return false;
    } else if (data.ansOption?.optionController.initalValue == null ||
        data.ansOption?.optionController.initalValue?.isNotEmpty == false) {
      NKToast.error(title: "Please Select Answer");
      return false;
    } else if (data.qustionCompletionTime == null) {
      NKToast.error(title: "Add Minimum 1 Second");
      return false;
    } else {
      return true;
    }
  }

  @override
  void didUpdateWidget(covariant QuizQuestionListWidget oldWidget) {
    questionList = widget.questionList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        qUIZZZDATAHANDLER.when(
          context: context,
          successBuilder: ($QUIZLIST) {
            return Column(
              children: List.generate(questionList.length, (index) {
                return questionListWidget(context, index, questionList[index]);
              }).addSpaceEveryWidget(space: 10.space),
            );
          },
        ),
        if (widget.quizCreateData != null) ...[
          nkSmallSizedBox,
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

  onAddQuestion() {
    setState(() {
      questionList.add(
        QuizAddQustionEditorModel(
          isNewData: true,
          isEditable: true,
          questionController: QuizAddEditorModel(
            hint: "Question",
            controller: QuillController.basic(editorFocusNode: FocusNode()),
          ),
        ),
      );
    });
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
          5.space,
          _questionTitle(quizAddQustionEditorModel, index),
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
        isReadOnly: !quizAddQustionEditorModel.isEditable,
        controller:
            TextEditingController(text: quizAddQustionEditorModel.marks),
        labelText: marksStr,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        onChanged: (value) {
          quizAddQustionEditorModel.marks = value.toString();
        },
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
              showAdaptiveDialog(
                  context: context,
                  builder: (builder) {
                    return MyDeleteDialog(
                      appBarTitle: quizAddQustionEditorModel
                              .questionController.initalValue ??
                          "",
                      onPressed: () async {
                        ApiWorker()
                            .deleteQuestion(
                                questionId: quizAddQustionEditorModel
                                    .quizData!.questionId
                                    .toString())
                            .then((value) {
                          if (value != null && value.status == true) {
                             setState(() {
  questionList.removeAt(index);
});
                          }
                            });
                      },
                    );
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
    // var questionType = widget.questionTypeList.firstWhereOrNull(
    //   (element) =>
    //       element.questionTypeId.toString() ==
    //       quizAddQustionEditorModel.quizData?.questionTypeId,
    // );
    return NkSearchableDropDownMenu<QuestionTypeData>(
        enableSearch: false,
        enabled: quizAddQustionEditorModel.isEditable,
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

  Widget _questionTitle(
      QuizAddQustionEditorModel quizAddEditorModel, int index) {
    return Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          widget.onQuestionChanged
              ?.call(quizAddEditorModel.questionController.controller);
        },
        child: Row(
          children: [
            MyRegularText(
              label: "${index + 1}.",
            ),
            10.space,
            Flexible(
              child: NkQuillEditor(
                isReaDOnly: !quizAddEditorModel.isEditable,
                initalContent:
                    quizAddEditorModel.questionController.initalValue,
                border: const Border(
                    bottom: BorderSide(color: textFieldBorderColor)),
                hint: quizAddEditorModel.questionController.hint,
                controller: quizAddEditorModel.questionController.controller,
                // controller: QuillEditorController(),
              ),
            )
          ],
        )

        // ListTile(
        //   horizontalTitleGap: 0,
        //   titleAlignment: ListTileTitleAlignment.titleHeight,
        //   contentPadding: 0.all,
        //   leading: MyRegularText(
        //     label: "${index + 1}.",
        //   ),
        //   title: NkQuillEditor(
        //     isReaDOnly: !quizAddEditorModel.isEditable,
        //     initalContent: quizAddEditorModel.questionController.initalValue,
        //     border: const Border(bottom: BorderSide(color: textFieldBorderColor)),
        //     hint: quizAddEditorModel.questionController.hint,
        //     controller: quizAddEditorModel.questionController.controller,
        //     // controller: QuillEditorController(),
        //   ),
        // ),
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
                    perentIndex, index, quizAddQustionEditorModel.isEditable);
              },
            ),
          ),
          if (stringToQuestionENUM(
                      quizAddQustionEditorModel.questionType?.name) ==
                  QuestionENUM.multiple &&
              quizAddQustionEditorModel.isEditable) ...[
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _durationWidget(quizAddQustionEditorModel),
              _addEditButton(quizAddQustionEditorModel),
            ],
          ),
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

  Widget _optionWidget(QuizQuestionOptionsEditorModel model, int perentIndex,
      int index, bool isEditable) {
    return CheckboxListTile.adaptive(
      hoverColor: transparent,
      enabled: isEditable,
      tileColor: transparent,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: 0.all,
      value:
          (questionList[perentIndex].ansOption?.optionController.initalValue ==
                  model.optionController.initalValue) &&
              questionList[perentIndex]
                      .ansOption
                      ?.optionController
                      .initalValue
                      ?.isNotEmpty ==
                  true,
      onChanged: (value) {
        for (int i = 0;
            i < (questionList[perentIndex].options?.length ?? 0);
            i++) {
          questionList[perentIndex].options?[i].optionController.initalValue =
              null;
        }
        if (value == true) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              setState(() {
                questionList[perentIndex].ansOption = model;
                questionList[perentIndex]
                        .ansOption
                        ?.optionController
                        .initalValue =
                    quillDeltaToHtml(model.optionController.controller.document
                        .toDelta()
                        .toJson());
                // currectAnswer = model;
              });
            },
          );
        }
      },
      title: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (event) {
          widget.onQuestionChanged?.call(model.optionController.controller);
        },
        child: NkQuillEditor(
          isReaDOnly: !isEditable,
          initalContent: model.optionController.initalValue,
          border: const Border(bottom: BorderSide(color: textFieldBorderColor)),
          hint: model.optionController.hint,
          controller: model.optionController.controller,
          // controller: QuillEditorController(),
        ),
      ),
      secondary: isEditable
          ? IconButton(
              onPressed: () {
                setState(() {
                  questionList[perentIndex].options?.removeAt(index);
                  questionList[perentIndex].ansOption = null;
                });
              },
              icon: const Icon(
                Icons.remove,
                color: errorColor,
              ))
          : null,
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
            initalContent: model.initalValue,
            editorKey: model.editorKey,
            border: Border.all(color: transparent),
            controller: model.controller,
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(QuizAddQustionEditorModel model) {
    if (model.description == null ||
        model.description?.optionController.initalValue == null) {
      return model.isEditable
          ? TextButton.icon(
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
              ))
          : 0.space;
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
              isReaDOnly: !model.isEditable,
              initalContent: model.description!.optionController.initalValue,
              hint: model.description!.optionController.hint,
              editorKey: model.description!.optionController.editorKey,
              controller: model.description!.optionController.controller,
            ),
          ),
          if (model.isEditable) ...[
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
          ]
        ],
      );
    }
  }

  Widget _durationWidget(QuizAddQustionEditorModel modelData) {
    return Row(
      children: [
        MyCommnonContainer(
            padding: 8.all,
            color: lightGreyColor,
            child: NkTimeCounterField(
              onChanged: (value) {
                modelData.qustionCompletionTime = value;
              },
              readOnly: !modelData.isEditable,
              initialDuration: modelData.qustionCompletionTime,
            )),
      ],
    );
  }

  Widget _addEditButton(QuizAddQustionEditorModel model) {
    if (model.isNewData) {
      return FittedBox(
        child: MyThemeButton(
          buttonText: saveStr,
          onPressed: () {
            if (validateQuestionField(model)) {
              uploadQuestion(model);
            }
          },
        ),
      );
    } else {
      if (model.isEditable) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  model.isEditable = false;
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
                buttonText: "$updateStr $questionStr",
                onPressed: null,
              ),
            )
          ].addSpaceEveryWidget(space: 5.space),
        );
      } else {
        return TextButton.icon(
            onPressed: () {
              setState(() {
                model.isEditable = true;
              });
            },
            label: const MyRegularText(label: editStr),
            icon: const Icon(
              Icons.edit,
              color: primaryIconColor,
            ));
      }
    }
  }
}
