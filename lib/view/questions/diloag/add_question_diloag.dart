import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_enable_disable_widget.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_get_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';

class AddQuestionDiloag extends StatefulWidget {
  final List<BoardListModel> boardList;
  const AddQuestionDiloag({super.key, required this.boardList});

  @override
  State<AddQuestionDiloag> createState() => _AddQuestionDiloagState();
}

class _AddQuestionDiloagState extends State<AddQuestionDiloag> {
  final DataHandler<List<StandardListModel>> standardList = DataHandler();
  final DataHandler<List<SubjectListModel>> subjectListData = DataHandler();
  final DataHandler<List<ChapterListModel>> chapterListData = DataHandler();

  BoardListModel? newSelectedBoard;
  StandardListModel? newSelectedStandard;

  getStandardData(String boardId) async {
    setState(() {
      standardList.startLoading();
    });
    // TempDataStore.standardList(boardId).then((value) {
    //   if (value != null && value.isNotEmpty) {
    //     setState(() {
    //       standardList.onSuccess(value);
    //     });
    //   } else {
    //     setState(() {
    //       standardList.onEmpty(ErrorStrings.noDataFound);
    //     });
    //   }
    // }).catchError((error, stackTrace) {
    //   setState(() {
    //     standardList.onError(error.toString());
    //   });
    // });
  }

  getSubjectData(String boardId, String standardId) async {
    setState(() {
      subjectListData.startLoading();
    });
    // TempDataStore.subjectList(boardId, standardId).then((value) {
    //   if (value != null && value.isNotEmpty) {
    //     setState(() {
    //       subjectListData.onSuccess(value);
    //     });
    //   } else {
    //     setState(() {
    //       subjectListData.onEmpty(ErrorStrings.noDataFound);
    //     });
    //   }
    // }).catchError((error, stackTrace) {
    //   setState(() {
    //     subjectListData.onError(error.toString());
    //   });
    // });
  }

  getChapter(String boardId, String standardId, String subjectId) async {
    setState(() {
      chapterListData.startLoading();
    });
    // FirebaseGetFun()
    //     .getChapterList(boardId, standardId, subjectId)
    //     .then((value) {
    //   if (value != null && value.isNotEmpty) {
    //     setState(() {
    //       chapterListData.onSuccess(value);
    //     });
    //   } else {
    //     setState(() {
    //       chapterListData.onEmpty(ErrorStrings.noDataFound);
    //     });
    //   }
    // }).catchError((error, stackTrace) {
    //   setState(() {
    //     chapterListData.onError(error.toString());
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      context: context,
      myAppBar: MyAppBar(
        heading: "$addStr $questionStr",
        isShowBackButton: context.isDesktop ? false : true,
        leading: context.isDesktop
            ? IconButton(
                onPressed: () => AppRoutes.navigator.pop(),
                icon: const Icon(Icons.home))
            : null,
      ),
      myBody: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyRegularText(
              label: questionStr,
              fontSize: NkFontSize.headingFont,
              fontWeight: NkGeneralSize.nkBoldFontWeight,
            ),
            FittedBox(
              child: MyThemeButton(
                  padding: 10.horizontal,
                  leadingIcon: const Icon(
                    Icons.add,
                    color: secondaryIconColor,
                  ),
                  buttonText: "$addStr $questionStr",
                  onPressed: () async {}),
            ),
          ],
        ),
        const MyRegularText(label: boardStr),
        NkSearchableDropDownMenu<BoardListModel>(
          hintText: "$selectStr $boardStr",
          initialSelection: widget.boardList.firstWhere(
            (element) => element.boardId?.contains("0ojhj") ?? false,
            orElse: () => BoardListModel(),
          ),
          onSelected: (p0) {
            newSelectedBoard = p0;
            // if (widget.studentListModel != null) {
            //   widget.studentListModel?.boardId = p0?.boardId;
            // }
            if (p0 != null) {
              getStandardData(p0.boardId!);
            }
          },
          dropdownMenuEntries: List.generate(
              widget.boardList.length,
              (index) => DropdownMenuEntry<BoardListModel>(
                    value: widget.boardList[index],
                    label: widget.boardList[index].boardName ?? "",
                  )),
        ),
        const MyRegularText(label: standardStr),
        standardList.when(
            context: context,
            successBuilder: (standardList) {
              return NkEnableDisableWidget(
                isEnable: standardList.isNotEmpty,
                child: NkSearchableDropDownMenu<StandardListModel>(
                  initialSelection: standardList.firstWhere(
                    (element) =>
                        element.standardId ==
                        "widget.studentListModel?.standardId",
                    orElse: () => StandardListModel(),
                  ),
                  hintText: "$selectStr $standardStr",
                  onSelected: (val) {
                    newSelectedStandard = val;
                    // if (widget.studentListModel != null) {
                    //   widget.studentListModel?.standardId = val?.standardId;
                    // }
                  },
                  dropdownMenuEntries: List.generate(
                      standardList.length,
                      (index) => DropdownMenuEntry<StandardListModel>(
                            value: standardList[index],
                            label: standardList[index].standardName ?? "",
                          )),
                ),
              );
            }),
        NkEnableDisableWidget(
          isEnable:
              subjectListData.data != null && subjectListData.data!.isNotEmpty,
          child: subjectListData.when(
              context: context,
              successBuilder: (standard) {
                return NkSearchableDropDownMenu<SubjectListModel>(
                  hintText: "$selectStr $subjectStr",
                  onSelected: (val) {
                    if (val != null) {
                      getChapter(val.boardId ?? "", val.standardId ?? "",
                          val.subjectId ?? "");
                    } else {
                      setState(() {
                        subjectListData
                            .onEmpty("${ErrorStrings.select} $standardStr");
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
        )
      ],
    );
  }
}
