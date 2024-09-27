
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/dialog/add_board_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class BordScreen extends StatefulWidget {
  const BordScreen({super.key});

  @override
  State<BordScreen> createState() => _BordScreenState();
}

class _BordScreenState extends State<BordScreen> {
  final DataHandler<List<BoardListModel>> boardListData = DataHandler();

  getBoardData() async {
    boardListData.startLoading();
    // TempDataStore.boardList.then((value) {
    //   if (value != null && value.isNotEmpty) {
    //     setState(() {
    //       boardListData.onSuccess(value);
    //     });
    //   } else {
    //     setState(() {
    //       boardListData.onEmpty(ErrorStrings.noDataFound);
    //     });
    //   }
    // }).catchError((error, stackTrace) {
    //   setState(() {
    //     boardListData.onError(error.toString());
    //   });
    // });
  }

  @override
  void initState() {
    getBoardData();
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
            MyRegularText(
              label: "$boardStr $listStr",
              fontSize: NkFontSize.headingFont,
            ),
            MyThemeButton(
                padding: 10.horizontal,
                leadingIcon: const Icon(
                  Icons.add,
                  color: secondaryIconColor,
                ),
                buttonText: "$addStr $boardStr",
                onPressed: () {
                  showAdaptiveDialog(
                      context: context,
                      builder: (builder) {
                        return AddBoardDiloag(
                          onBoardUpdated: (board) {
                            setState(() {
                              if (board != null &&
                                  boardListData.data!.isNotEmpty) {
                                boardListData.data?.add(board);
                                boardListData
                                    .onUpdate(boardListData.data ?? []);
                                TempDataStore.tempBoardList.value
                                    ?.addAll(boardListData.data ?? []);
                              } else if (board != null) {
                                boardListData.onSuccess([board]);
                                TempDataStore.tempBoardList.value?.add(board);
                              }
                            });
                          },
                        );
                      });
                }),
          ],
        ),
        Flexible(child: boardList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  Widget boardComponent(BoardListModel board, int index) {
    return MyCommnonContainer(
        isCardView: true,
        padding: nkRegularPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  MyNetworkImage(imageUrl: board.image ?? ""),
                  nkExtraSmallSizedBox,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyRegularText(
                          align: TextAlign.start,
                          label: board.boardName ?? "",
                        ),
                        MyRegularText(
                          label: board.createAt ?? "",
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
                            return AddBoardDiloag(
                              boardListModel: board,
                              onBoardUpdated: (board) {
                                setState(() {
                                  if (board != null) {
                                    boardListData.data?[index] = board;
                                    TempDataStore.tempBoardList.value?[index] =
                                        board;
                                  }
                                });
                              },
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
                              appBarTitle: board.boardName ?? "",
                              onPressed: () async {
                                // await FirebaseDeleteFun()
                                //     .deleteBoard(board.boardId ?? "",
                                //         imageUrl: board.image)
                                //     .whenComplete(() {
                                //   NKToast.success(
                                //       title:
                                //           "${board.boardName} ${SuccessStrings.deletedSuccessfully}");
                                //   setState(() {
                                //     boardListData.data?.removeAt(index);
                                //     // TempDataStore.tempBoardList.value
                                //     //     ?.removeAt(index);
                                //   });
                                // });
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

  Widget boardList() {
    return boardListData.when(
      context: context,
      successBuilder: (boardList) {
        return ResponsiveGridList(
          minItemWidth: context.isMobile ? context.width : 300,
          minItemsPerRow: 1,
          maxItemsPerRow: 4,
          children: List.generate(boardList.length, (index) {
            return boardComponent(boardList[index], index);
          }).toList(),
        );
      },
    );
  }
}
