import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_enable_disable_widget.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/questions/diloag/add_question_diloag.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final DataHandler<List<BoardListModel>> boardListData = DataHandler();
  final DataHandler<List<StandardListModel>> standardListData = DataHandler();
  final DataHandler<List<SubjectListModel>> subjectListData = DataHandler();
  final DataHandler<List<ChapterListModel>> chapterListData = DataHandler();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBoardData();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(context: context, myBody: _body(context));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: [
                  MyRegularText(
                    label: "$questionStr $listStr",
                    fontSize: NkFontSize.headingFont,
                  ),
                  boardListData.when(
                      context: context,
                      successBuilder: (boardList) {
                        return NkSearchableDropDownMenu<BoardListModel>(
                          hintText: "$selectStr $boardStr",
                          onSelected: (board) {
                            if (board != null) {
                              getStandardData(board.boardId ?? "");
                            } else {
                              setState(() {
                                subjectListData.onEmpty(
                                    "${ErrorStrings.select} $boardStr");
                              });
                            }
                          },
                          dropdownMenuEntries: List.generate(
                              boardList.length,
                              (index) => DropdownMenuEntry<BoardListModel>(
                                    value: boardList[index],
                                    label: boardList[index].boardName ?? "",
                                  )),
                        );
                      }),
                  NkEnableDisableWidget(
                    isEnable: standardListData.data != null &&
                        standardListData.data!.isNotEmpty,
                    child: standardListData.when(
                        context: context,
                        successBuilder: (standard) {
                          return NkSearchableDropDownMenu<StandardListModel>(
                            hintText: "$selectStr $standardStr",
                            onSelected: (val) {
                              if (val != null) {
                                getSubjectData(
                                    val.boardId ?? "", val.standardId ?? "");
                              } else {
                                setState(() {
                                  subjectListData.onEmpty(
                                      "${ErrorStrings.select} $standardStr");
                                });
                              }
                            },
                            dropdownMenuEntries: List.generate(
                                standard.length,
                                (index) => DropdownMenuEntry<StandardListModel>(
                                      value: standard[index],
                                      label: standard[index].standardName ?? "",
                                    )),
                          );
                        }),
                  ),
                  NkEnableDisableWidget(
                    isEnable: subjectListData.data != null &&
                        subjectListData.data!.isNotEmpty,
                    child: subjectListData.when(
                        context: context,
                        successBuilder: (standard) {
                          return NkSearchableDropDownMenu<SubjectListModel>(
                            hintText: "$selectStr $subjectStr",
                            onSelected: (val) {
                              if (val != null) {
                                getChapter(val.boardId ?? "",
                                    val.standardId ?? "", val.subjectId ?? "");
                              } else {
                                setState(() {
                                  subjectListData.onEmpty(
                                      "${ErrorStrings.select} $standardStr");
                                });
                              }
                            },
                            dropdownMenuEntries: List.generate(
                                standard.length,
                                (index) => DropdownMenuEntry<SubjectListModel>(
                                      value: standard[index],
                                      label: standard[index].subjectName ?? "",
                                    )),
                          );
                        }),
                  ),
                  NkEnableDisableWidget(
                    isEnable: chapterListData.data != null &&
                        chapterListData.data!.isNotEmpty,
                    child: chapterListData.when(
                        context: context,
                        successBuilder: (chapterList) {
                          return NkSearchableDropDownMenu<ChapterListModel>(
                            hintText: "$selectStr $chapterStr",
                            onSelected: (val) {
                              if (val != null) {
                                // getChapter(val.boardId ?? "",
                                //     val.standardId ?? "", val.subjectId ?? "");
                              } else {
                                setState(() {
                                  chapterListData.onEmpty(
                                      "${ErrorStrings.select} $subjectStr");
                                });
                              }
                            },
                            dropdownMenuEntries: List.generate(
                                chapterList.length,
                                (index) => DropdownMenuEntry<ChapterListModel>(
                                      value: chapterList[index],
                                      label:
                                          chapterList[index].chapterName ?? "",
                                    )),
                          );
                        }),
                  ),
                ].addSpaceEveryWidget(
                  space: nkExtraSmallSizedBox,
                ),
              ),
            ),
            MyThemeButton(
                padding: 10.horizontal,
                leadingIcon: const Icon(
                  Icons.add,
                  color: secondaryIconColor,
                ),
                buttonText: "$addStr $questionStr",
                onPressed: () async {
                  AppRoutes.navigator
                      .goNamed(AppRoutes.addQuestionScreen, queryParameters: {
                    "boardList": boardListData.data,
                  });
                }),
          ],
        )
      ],
    );
  }

  getBoardData() async {
    boardListData.startLoading();
    TempDataStore.boardList.then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          boardListData.onSuccess(value);
        });
      } else {
        setState(() {
          boardListData.onEmpty(ErrorStrings.noDataFound);
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        boardListData.onError(error.toString());
      });
    });
  }

  getStandardData(String boardId) async {
    setState(() {
      standardListData.startLoading();
    });
    TempDataStore.standardList(boardId).then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          standardListData.onSuccess(value);
        });
      } else {
        setState(() {
          standardListData.onEmpty(ErrorStrings.noDataFound);
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        standardListData.onError(error.toString());
      });
    });
  }

  getSubjectData(String boardId, String standardId) async {
    setState(() {
      subjectListData.startLoading();
    });
    TempDataStore.subjectList(boardId, standardId).then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          subjectListData.onSuccess(value);
        });
      } else {
        setState(() {
          subjectListData.onEmpty(ErrorStrings.noDataFound);
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        subjectListData.onError(error.toString());
      });
    });
  }

  getChapter(String boardId, String standardId, String subjectId) async {
    setState(() {
      chapterListData.startLoading();
    });
    FirebaseGetFun()
        .getChapterList(boardId, standardId, subjectId)
        .then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          chapterListData.onSuccess(value);
        });
      } else {
        setState(() {
          chapterListData.onEmpty(ErrorStrings.noDataFound);
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        chapterListData.onError(error.toString());
      });
    });
  }
}
