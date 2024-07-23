import 'package:m_and_r_quiz_admin_panel/components/common_diloag/my_delete_dialog.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_network_image.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_enable_disable_widget.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_delete_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/dialog/add_chapter_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final DataHandler<List<BoardListModel>> boardListData = DataHandler();
  final DataHandler<List<StandardListModel>> standardListData = DataHandler();
  final DataHandler<List<SubjectListModel>> subjectListData = DataHandler();
  final DataHandler<List<ChapterListModel>> chapterListData = DataHandler();

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

  @override
  void initState() {
    getBoardData();
    subjectListData
        .onEmpty("$selectStr $boardStr & $standardStr & $chapterStr");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nkExtraSmallSizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  MyRegularText(
                    label: "$chapterStr $listStr",
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
                buttonText: "$addStr $chapterStr",
                onPressed: () async {
                  showAdaptiveDialog<StandardListModel?>(
                      context: context,
                      builder: (builder) {
                        return AddChapterDiloag(
                          boardList: boardListData.data ?? [],
                          onChapterUpdated: (board) {
                            try {
                              setState(() {
                                if (board != null &&
                                    subjectListData.data?.isNotEmpty == true) {
                                  chapterListData.data?.add(board);

                                  return;
                                } else if (board != null) {
                                  chapterListData.onSuccess([board]);

                                  return;
                                }
                              });
                              if (board != null) {}
                            } on Exception catch (e) {
                              nkDevLog("ADD CHAPTER ERROR: ${e.toString()}",
                                  error: e.toString());
                            }
                          },
                        );
                      }).then((value) {});
                }),
          ],
        ),
        Flexible(child: chapterList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  Widget chapterComponent(ChapterListModel chapter, int index) {
    return MyCommnonContainer(
        isCardView: true,
        padding: nkRegularPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  MyNetworkImage(imageUrl: chapter.image ?? ""),
                  nkExtraSmallSizedBox,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyRegularText(
                          align: TextAlign.start,
                          label: chapter.chapterName ?? "",
                        ),
                        MyRegularText(
                          label: chapter.createAt ?? "",
                          fontSize: NkFontSize.extraSmallFont,
                          color: secondaryTextColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              children: [
                IconButton(
                    onPressed: () {
                      showAdaptiveDialog(
                          context: context,
                          builder: (builder) {
                            return AddChapterDiloag(
                              chapterListModel: chapter,
                              onChapterUpdated: (board) {
                                setState(() {
                                  if (board != null) {
                                    chapterListData.data?[index] = board;
                                  }
                                });
                              },
                              boardList: boardListData.data ?? [],
                            );
                          });
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showAdaptiveDialog(
                          context: context,
                          builder: (builder) {
                            return MyDeleteDialog(
                              appBarTitle: chapter.chapterName ?? "",
                              onPressed: () async {
                                await FirebaseDeleteFun()
                                    .deleteChapter(
                                        chapter.boardId ?? "",
                                        chapter.standardId ?? "",
                                        chapter.subjectId ?? "",chapter.chapterId??"",
                                        imageUrl: chapter.image)
                                    .whenComplete(() {
                                  NKToast.success(
                                      title:
                                          "${chapter.chapterName} ${SuccessStrings.deletedSuccessfully}");
                                  setState(() {
                                    subjectListData.data?.removeAt(index);
                                    TempDataStore.tempSubjectList.value
                                        ?.removeAt(index);
                                  });
                                });
                              },
                            );
                          }).then((value) {
                        setState(() {});
                      });
                    },
                    icon: const Icon(Icons.delete_forever))
              ],
            ),
          ],
        ));
  }

  Widget chapterList() {
    return chapterListData.when(
      context: context,
      successBuilder: (chapterList) {
        return ResponsiveGridList(
          minItemWidth: context.isMobile ? context.width : 300,
          minItemsPerRow: 1,
          maxItemsPerRow: 4,
          children: List.generate(chapterList.length, (index) {
            return chapterComponent(chapterList[index], index);
          }).toList(),
        );
      },
    );
  }
}
