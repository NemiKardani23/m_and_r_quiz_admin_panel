import 'package:m_and_r_quiz_admin_panel/components/common_diloag/my_delete_dialog.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_network_image.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_delete_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/dialog/add_standard_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class StandardScreen extends StatefulWidget {
  const StandardScreen({super.key});

  @override
  State<StandardScreen> createState() => _StandardScreenState();
}

class _StandardScreenState extends State<StandardScreen> {
  final DataHandler<List<BoardListModel>> boardListData = DataHandler();
  final DataHandler<List<StandardListModel>> standardListData = DataHandler();

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

  @override
  void initState() {
    getBoardData();
    standardListData.onEmpty("$selectStr $boardStr");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nkExtraSmallSizedBox,
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          spacing: 10,
          runSpacing: 10,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyRegularText(
                  label: "$standardStr $listStr",
                  fontSize: NkFontSize.headingFont,
                ),
                nkExtraSmallSizedBox,
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
                              standardListData
                                  .onEmpty("${ErrorStrings.select} $boardStr");
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
              ],
            ),
            FittedBox(
              child: MyThemeButton(
                  padding: 10.horizontal,
                  leadingIcon: const Icon(
                    Icons.add,
                    color: secondaryIconColor,
                  ),
                  buttonText: "$addStr $standardStr",
                  onPressed: () async {
                    showAdaptiveDialog<StandardListModel?>(
                        context: context,
                        builder: (builder) {
                          return AddStandardDiloag(
                            boardList: boardListData.data ?? [],
                            onBoardUpdated: (board) {
                              try {
                                setState(() {
                                  if (board != null &&
                                      standardListData.data?.isNotEmpty ==
                                          true) {
                                    TempDataStore.tempStandardList.value
                                        ?.add(board);

                                    return;
                                  } else if (board != null) {
                                    standardListData.onSuccess([board]);
                                    TempDataStore.tempStandardList.value
                                        ?.add(board);
                                    return;
                                  }
                                });
                                if (board != null) {}
                              } on Exception catch (e) {
                                nkDevLog("AddStandardDiloag",
                                    error: e.toString());
                              }
                            },
                          );
                        }).then((value) {});
                  }),
            ),
          ],
        ),
        Flexible(child: standardList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  Widget standardComponent(StandardListModel standard, int index) {
    return MyCommnonContainer(
        isCardView: true,
        padding: nkRegularPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  MyNetworkImage(imageUrl: standard.image ?? ""),
                  nkExtraSmallSizedBox,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyRegularText(
                          align: TextAlign.start,
                          label: standard.standardName ?? "",
                        ),
                        MyRegularText(
                          label: standard.createAt ?? "",
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
                            return AddStandardDiloag(
                              standardListModel: standard,
                              onBoardUpdated: (board) {
                                setState(() {
                                  if (board != null) {
                                    standardListData.data?[index] = board;
                                    TempDataStore
                                        .tempStandardList.value?[index] = board;
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
                              appBarTitle: standard.standardName ?? "",
                              onPressed: () async {
                                await FirebaseDeleteFun()
                                    .deleteStandard(standard.boardId ?? "",
                                        standard.standardId ?? "",
                                        imageUrl: standard.image)
                                    .whenComplete(() {
                                  NKToast.success(
                                      title:
                                          "${standard.standardName} ${SuccessStrings.deletedSuccessfully}");
                                  setState(() {
                                    standardListData.data?.removeAt(index);
                                    TempDataStore.tempStandardList.value
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

  Widget standardList() {
    return standardListData.when(
      context: context,
      successBuilder: (standardList) {
        return ResponsiveGridList(
          minItemWidth: context.isMobile ? context.width : 300,
          minItemsPerRow: 1,
          maxItemsPerRow: 4,
          children: List.generate(standardList.length, (index) {
            return standardComponent(standardList[index], index);
          }).toList(),
        );
      },
    );
  }
}
