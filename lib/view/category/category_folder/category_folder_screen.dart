import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/add_category_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class CategoryFolderScreen extends StatefulWidget {
  final String? categoryId;
  final num? lavel;
  final GoRouterState? routingState;
  final String? routeChildrenPath;
  const CategoryFolderScreen({
    super.key,
    this.categoryId,
    this.lavel,
    this.routingState,
    this.routeChildrenPath,
  });

  @override
  State<CategoryFolderScreen> createState() => _CategoryFolderScreenState();
}

class _CategoryFolderScreenState extends State<CategoryFolderScreen> {
  DataHandler<List<CategoryData>> categoryData = DataHandler();
  DataHandler<List<FileTypeData>> fileTypeData = DataHandler();
  DataHandler<List<CategoryTypeData>> categoryTypeData = DataHandler();

  List<Map<String, String>> childRoutesData = [];

  @override
  initState() {
    super.initState();
    callApi(
      perentId: widget.categoryId?.toString(),
      categoryLavel: widget.lavel?.toString(),
    );
    getMediaTypeData();
    childRoutesData = NkCommonFunction.convertStringToListMap(
            widget.routeChildrenPath ?? "") ??
        [];
  }

  void getMediaTypeData() async {
    fileTypeData.startLoading();
    TempDataStore.getFileTypeList.then(
      (value) {
        if (value != null) {
          setState(() {
            fileTypeData.onSuccess(value);
          });
        }
      },
    );
    TempDataStore.getCategoryTypeList.then(
      (value) {
        if (value != null) {
          setState(() {
            categoryTypeData.onSuccess(value);
          });
        }
      },
    );
  }

  callApi({
    String? id,
    String? perentId,
    String? categoryLavel,
  }) {
    categoryData.startLoading();
    ApiWorker()
        .getCategoryList(
            id: id, perentId: perentId, categoryLavel: categoryLavel)
        .then(
      (value) {
        if (value != null &&
            value.status == true &&
            value.data.isNotEmpty == true) {
          setState(() {
            categoryData.onSuccess(value.data);
          });
        } else {
          setState(() {
            categoryData.onEmpty(value?.message ?? ErrorStrings.noDataFound);
          });
        }
      },
    ).catchError((value) {
      setState(() {
        categoryData.onError(ErrorStrings.oopsSomethingWentWrong);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: MyCommnonContainer(
                isCardView: true,
                margin: nkRegularPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyRegularText(
                          label: "$categoryStr $sectionStr",
                          fontSize: NkFontSize.headingFont,
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(
                        childRoutesData.length,
                        (index) {
                          var mapData = childRoutesData[index];

                          return InkWell(
                            onTap: () {
                              var pathUri = mapData["pathUri"]?.toString();
                              if (pathUri?.isNotEmpty == true) {
                                context.go(pathUri!);
                              } else {
                                AppRoutes.navigator.pushReplacementNamed(
                                    AppRoutes.categoryScreen);
                                // CategoryData categoryData = CategoryData.fromJson({});
                                // _handleRoute(categoryData.copyWith(
                                //   id: int.tryParse(mapData["id"].toString()),
                                //   name: mapData["name"].toString(),
                                //   categoryLevel:
                                //       num.tryParse(mapData["level"].toString()),
                                // ),isAddChild:  false);
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyRegularText(
                                    label: mapData["name"].toString()),
                                if (index != childRoutesData.length - 1) ...[
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: primaryIconColor.withOpacity(0.5),
                                    size: 20,
                                  )
                                ]
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            fileTypeData.when(
              context: context,
              successBuilder: (catTypeList) {
                return PopupMenuButton<CategoryTypeENUM>(
                  tooltip: "$addStr $folderStr",
                  icon: MyCommnonContainer(
                    padding: 10.all,
                    isCardView: true,
                    child: const Icon(Icons.add),
                  ),
                  onSelected: (value) {
                    // CategoryData? data;
                    // if (categoryData.data != null &&
                    //     categoryData.data?.isNotEmpty == true) {
                    //   data = categoryData.data?.firstWhere((element) =>
                    //       element.parentId.toString() == widget.categoryId);
                    // }
                    showAdaptiveDialog(
                      builder: (context) {
                        return Center(
                          child: MyScrollView(
                            children: [
                              AddCategoryDiloag(
                                parentId: widget.categoryId?.toString(),
                                fileTypeModel: catTypeList.firstWhere(
                                    (element) =>
                                        element.typeName?.toUpperCase() ==
                                        value.categoryType),
                                categoryType: value,
                                onUpdated: (catData) {
                                  callApi(
                                    perentId: widget.categoryId?.toString(),
                                    categoryLavel: widget.lavel?.toString(),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      context: context,
                    );
                  },
                  itemBuilder: (context) {
                    return List.generate(
                      catTypeList.length,
                      (index) {
                        return PopupMenuItem(
                          value: convertStringToCategoryType(
                              (catTypeList[index].typeName ?? "")
                                  .toUpperCase()),
                          child: ListTile(
                            leading: const Icon(Icons.folder),
                            title: MyRegularText(
                                align: TextAlign.start,
                                label: catTypeList[index].typeName ?? ""),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
        Flexible(child: boardList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  List<PopupMenuItem> _editDeleteViewOptions(
      CategoryData _categoryData, int index) {
    var fileTypeViewData = fileTypeData.data?.firstWhere(
      (element) => element.id == _categoryData.fileTypeId,
    );
    return [
      PopupMenuItem(
        child: ListTile(
          contentPadding: 0.all,
          leading: const Icon(CupertinoIcons.pencil),
          title: const MyRegularText(label: editStr),
        ),
      ),
      PopupMenuItem(
        onTap: () {
          showAdaptiveDialog(
              context: context,
              builder: (builder) {
                return MyDeleteDialog(
                  appBarTitle:
                      "$deleteStr ${_categoryData.name} ${fileTypeViewData?.typeName}",
                  onPressed: () async {
                    ApiWorker()
                        .deleteCategory(categoryId: _categoryData.id.toString())
                        .then(
                      (value) {
                        if (value != null && value.status == true) {
                          NKToast.success(
                              title: "${_categoryData.name} ${SuccessStrings.deletedSuccessfully}");
                          setState(() {
                            categoryData.data?.removeAt(index);
                          });
                        }
                      },
                    );
                    // await FirebaseDeleteFun()
                    //     .deleteChapter(
                    //         chapter.boardId ?? "",
                    //         chapter.standardId ?? "",
                    //         chapter.subjectId ?? "",
                    //         chapter.chapterId ?? "",
                    //         imageUrl: chapter.image)
                    //     .whenComplete(() {
                    //   NKToast.success(
                    //       title:
                    //           "${chapter.chapterName} ${SuccessStrings.deletedSuccessfully}");
                    //   setState(() {
                    //     chapterListData.data?.removeAt(index);
                    //   });
                    // });
                  },
                );
              }).then((value) {
            setState(() {});
          });
        },
        child: ListTile(
          contentPadding: 0.all,
          leading: const Icon(
            CupertinoIcons.trash,
            color: errorColor,
          ),
          title: const MyRegularText(label: deleteStr),
        ),
      ),
    ];
  }

  Widget boardComponent(CategoryData categoryData, int index) {
    return MyCommnonContainer(
      isCardView: true,
      onTap: () {
        _handleRoute(categoryData);
      },
      padding: 10.all,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              right: 2,
              top: 0,
              child: PopupMenuButton(
                tooltip: "More",
                child: const Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return _editDeleteViewOptions(categoryData, index);
                },
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.folder,
                size: 1.dp,
              ),
              MyRegularText(label: categoryData.name ?? ""),
              _detailsChips(categoryData)
            ],
          )
        ],
      ),
    );
  }

  Widget _detailsChips(CategoryData categoryData) {
    var categoryTypeViewData = categoryTypeData.data?.firstWhere(
      (element) => element.id == categoryData.typeId,
    );
    var fileTypeViewData = fileTypeData.data?.firstWhere(
      (element) => element.id == categoryData.fileTypeId,
    );
    return Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 0,
        children: [
          Chip(
            padding: 8.horizontal,
            shape: RoundedRectangleBorder(
                borderRadius: NkGeneralSize.nkCommonBorderRadius),
            labelPadding: 0.all,
            label: MyRegularText(
              label: categoryTypeViewData?.name ?? "",
              fontSize: NkFontSize.smallFont,
            ),
            color: WidgetStatePropertyAll(successPrimary.withOpacity(.2)),
          ),
          Chip(
            padding: 8.horizontal,
            shape: RoundedRectangleBorder(
                borderRadius: NkGeneralSize.nkCommonBorderRadius),
            labelPadding: 0.all,
            label: MyRegularText(
              label: fileTypeViewData?.typeName ?? "",
              fontSize: NkFontSize.smallFont,
            ),
            color: WidgetStatePropertyAll(warningPrimary.withOpacity(.2)),
          ),
          Chip(
            padding: 8.horizontal,
            shape: RoundedRectangleBorder(
                borderRadius: NkGeneralSize.nkCommonBorderRadius),
            labelPadding: 0.all,
            label: MyRegularText(
              label: categoryData.status ?? "",
              fontSize: NkFontSize.smallFont,
            ),
            color: WidgetStatePropertyAll(infoPrimary.withOpacity(.2)),
          ),
        ]);
  }

  Widget boardList() {
    return categoryData.when(
      context: context,
      successBuilder: (boardList) {
        return ResponsiveGridList(
          minItemWidth: context.isMobile ? context.width : 200,
          minItemsPerRow: 2,
          maxItemsPerRow: 4,
          children: List.generate(boardList.length, (index) {
            return boardComponent(boardList[index], index);
          }).toList(),
        );
      },
    );
  }

  _handleRoute(CategoryData categoryData, {bool isAddChild = true}) {
    Map<String, String> pathData = {
      "id": categoryData.id.toString(),
      "lavel": ((categoryData.categoryLevel ?? 0) + 1).toString(),
    };
    //   Map<String, String> routePathData = {
    //   "id": categoryData.id.toString(),
    //   "lavel": ((categoryData.categoryLevel ?? 0) + 1).toString(),
    // };
    // var nameData = {
    //   "routeChildPath": jsonEncode(pathData..addAll({"name": categoryData.name ?? ""}))
    // };
    if (isAddChild) {
      childRoutesData.addAll([
        {
          "name": categoryData.name ?? "",
          "id": categoryData.id.toString(),
          "lavel": ((categoryData.categoryLevel ?? 0) + 1).toString(),
          "pathUri": widget.routingState?.uri.path.toString() ?? ""
        }
      ]);
    }
    pathData.addAll({'routeChildPath': childRoutesData.toString()});
    nkDevLog("PATH DATA : $pathData");
    AppRoutes.navigator.goNamed(
      AppRoutes.subCategoryScreen,
      pathParameters: pathData,
    );
  }
}
