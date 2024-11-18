import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/components/document_viewer/nk_doc_viewer.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_html_viewer/nk_html_viewer_web.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_toggle_button.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/add_category_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/diloag/model/quiz_create_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class CategoryFolderScreen extends StatefulWidget {
  final String? categoryId;
  final num? lavel;
  final GoRouterState? routingState;
  final String? routeChildrenPath;
  final String? fileType;
  const CategoryFolderScreen({
    super.key,
    this.categoryId,
    this.lavel,
    this.routingState,
    this.routeChildrenPath,
    this.fileType,
  });

  @override
  State<CategoryFolderScreen> createState() => _CategoryFolderScreenState();
}

class _CategoryFolderScreenState extends State<CategoryFolderScreen> {
  DataHandler<List<CategoryData>> categoryData = DataHandler();
  DataHandler<List<FileTypeData>> fileTypeData = DataHandler();
  DataHandler<List<CategoryTypeData>> categoryTypeData = DataHandler();
  DataHandler<List<QuizCreateData>> quizDataList =
      DataHandler<List<QuizCreateData>>();

  List<Map<String, String>> childRoutesData = [];

  CategoryTypeENUM? fileTypeENUM;

  FileTypeData? selectedToggleType;

  @override
  initState() {
    super.initState();
    fileTypeENUM = convertStringToCategoryType(widget.fileType ?? "FOLDER");
    if (fileTypeENUM == CategoryTypeENUM.folder) {
      callApi(
        perentId: widget.categoryId?.toString(),
        categoryLavel: widget.lavel?.toString(),
      );
    } else if (fileTypeENUM == CategoryTypeENUM.document ||
        fileTypeENUM == CategoryTypeENUM.ePublisher) {
      callApi(
        id: widget.categoryId?.toString(),
      );
    }

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
    String? fileTypeId,
  }) {
    if (mounted) {
      setState(() {
        categoryData.startLoading();
      });
    }

    ApiWorker()
        .getCategoryList(
            id: id,
            perentId: perentId,
            categoryLavel: categoryLavel,
            fileTypeId: fileTypeId)
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

  callQuizApi({required String categoryId}) {
    if (mounted) {
      setState(() {
        quizDataList.startLoading();
      });
    }
    ApiWorker().getQuizList(categoryId: categoryId).then(
      (value) {
        if (value != null &&
            value.status == true &&
            value.data.isNotEmpty == true) {
          setState(() {
            quizDataList.onSuccess(value.data);
          });
        } else {
          setState(() {
            quizDataList.onEmpty(value?.message ?? ErrorStrings.noDataFound);
          });
        }
      },
    ).catchError((value) {
      setState(() {
        quizDataList.onError(ErrorStrings.oopsSomethingWentWrong);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: MyCommnonContainer(
                isCardView: true,
                margin: nkRegularPadding,
                color: transparent,
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
                                FittedBox(
                                  child: MyRegularText(
                                      label: mapData["name"].toString()),
                                ),
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
            if (fileTypeENUM == CategoryTypeENUM.folder) ...[
              fileTypeData.when(
                context: context,
                successBuilder: (catTypeList) {
                  return PopupMenuButton<CategoryTypeENUM>(
                    tooltip: addStr,
                    icon: MyThemeButton(
                      padding: 10.horizontal,
                      leadingIcon: const Icon(
                        Icons.add,
                        color: primaryIconColor,
                      ),
                      buttonText: "",
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
                            child: AddCategoryDiloag(
                              parentId: widget.categoryId?.toString(),
                              fileTypeModel: catTypeList.firstWhere((element) =>
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
            ]
          ],
        ),
        if (!isPerentCategory) ...[
          _fileTypeTab(),
        ],
        Flexible(child: categoryList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  List<PopupMenuItem> _editDeleteViewOptions(CategoryData catData, int index) {
    var fileTypeViewData = fileTypeData.data?.firstWhere(
      (element) => element.id == catData.fileTypeId,
    );
    var categoryTypeViewData = categoryTypeData.data?.firstWhere(
      (element) => element.id == catData.typeId,
    );
    return [
      PopupMenuItem(
        onTap: () {
          _handleEditCategory(
              catData, fileTypeViewData!, categoryTypeViewData!);
        },
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
                      "$deleteStr ${catData.name} ${fileTypeViewData?.typeName}",
                  onPressed: () async {
                    ApiWorker()
                        .deleteCategory(categoryId: catData.id.toString())
                        .then(
                      (value) {
                        if (value != null && value.status == true) {
                          NKToast.success(
                              title:
                                  "${catData.name} ${SuccessStrings.deletedSuccessfully}");
                          setState(() {
                            categoryData.data?.removeAt(index);
                          });
                        }
                      },
                    );
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
      onDoubleTap: () {
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
              _categoryIcon(categoryData),
              MyRegularText(label: categoryData.name ?? ""),
              _detailsChips(
                fileTypeId: categoryData.fileTypeId,
                typeId: categoryData.typeId,
                status: categoryData.status,
              ),
              5.space,
              _activeInActiveSelector(
                status: categoryData.status ?? "inactive",
                onValueChanged: (value) {
                  ApiWorker()
                      .changeCategoryStatus(
                          status: value ?? "", id: categoryData.id.toString())
                      .then((response) {
                    if (response != null && response.status == true) {
                      setState(() {
                        categoryData = categoryData.copyWith(status: value);
                      });
                    }
                  });
                },
              ),
            ].addSpaceEveryWidget(space: 5.space),
          )
        ],
      ),
    );
  }

  Widget _activeInActiveSelector(
      {required String status, void Function(String?)? onValueChanged}) {
    return CupertinoSlidingSegmentedControl<String>(
      backgroundColor: primaryColor,
      thumbColor: selectionColor,
      onValueChanged: onValueChanged ?? (val) {},
      groupValue: status,
      children: _statusTypeOptions(),
    );
  }

  Map<String, Widget> _statusTypeOptions() {
    return {
      "active": MyRegularText(
        label: "Active",
        fontSize: NkFontSize.smallFont,
      ),
      "inactive": MyRegularText(
        label: "Inactive",
        fontSize: NkFontSize.smallFont,
      ),
    };
  }

  Widget quizComponent(QuizCreateData quizzzzData, int index) {
    var fileData = fileTypeData.data?.firstWhere(
      (element) => element.id == quizzzzData.fileTypeId,
    );
    return MyCommnonContainer(
      isCardView: true,
      onDoubleTap: () {
        showAdaptiveDialog(
          builder: (context) {
            return Center(
              child: AddCategoryDiloag(
                quizCreateData: quizzzzData,
                parentId: widget.categoryId?.toString(),
                fileTypeModel: fileData!,
                categoryType: CategoryTypeENUM.exam,
                onUpdated: (catData) {
                  callApi(
                    perentId: widget.categoryId?.toString(),
                    categoryLavel: widget.lavel?.toString(),
                  );
                },
              ),
            );
          },
          context: context,
        );
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
                  return [
                    PopupMenuItem(
                      onTap: () {
                        showAdaptiveDialog(
                            context: context,
                            builder: (builder) {
                              return MyDeleteDialog(
                                appBarTitle: "$deleteStr ${fileData?.typeName}",
                                onPressed: () async {
                                  ApiWorker()
                                      .deleteQuiz(
                                          quizId: quizzzzData.testId.toString())
                                      .then(
                                    (value) {
                                      if (value != null &&
                                          value.status == true) {
                                        NKToast.success(
                                            title: SuccessStrings
                                                .deletedSuccessfully);
                                        setState(() {
                                          quizDataList.data?.removeAt(index);
                                        });
                                      }
                                    },
                                  );
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
                    )
                  ];
                },
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (quizzzzData.thumbnail != null) ...[
                MyNetworkImage(
                  imageUrl: quizzzzData.thumbnail ?? "",
                  appHeight: 1.dp,
                  appWidth: 1.dp,
                )
              ] else ...[
                Image.asset(Assets.assetsIconsExam,
                    height: 1.dp, width: 1.dp, fit: BoxFit.cover)
              ],
              Center(
                child: FittedBox(
                  child: NkHtmlViewerWEB(
                    htmlContent: quizzzzData.title ?? "",
                  ),
                ),
              ),
              5.space,
              _detailsChips(
                fileTypeId: quizzzzData.fileTypeId,
                typeId: quizzzzData.typeId,
                status: quizzzzData.status,
              ),
              10.space,
              _activeInActiveSelector(
                status: quizzzzData.status ?? "inactive",
                onValueChanged: (value) async {
                  var data = await ApiWorker()
                      .changeQuestionStatus(
                          status: value ?? "",
                          id: quizzzzData.testId.toString())
                      .then((response) {
                    if (response != null && response.status == true) {
                      NKToast.success(title: response.message);
                      return value;
                    }
                  });
                  setState(() {
                    quizDataList.data?[index] = quizzzzData.copyWith(
                      status: data,
                    );
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _categoryIcon(CategoryData categoryData) {
    var fileTypeViewData = fileTypeData.data?.firstWhere(
      (element) => element.id == categoryData.fileTypeId,
    );
    CategoryTypeENUM fileTypeENUM = convertStringToCategoryType(
        (fileTypeViewData?.typeName ?? "").toUpperCase());

    double iconSize = context.isMobile || context.isTablet ? 60 : 1.dp;

    switch (fileTypeENUM) {
      case CategoryTypeENUM.folder:
        if (categoryData.image != null) {
          return MyNetworkImage(
            imageUrl: categoryData.image ?? "",
            appHeight: iconSize,
            appWidth: iconSize,
            fit: BoxFit.fill,
          );
        } else {
          // return Icon(
          //   Icons.folder,
          //   size: 1.dp,
          // );
          return Image.asset(Assets.assetsIconsOpenFolder,
              // color: selectionColor,
              height: iconSize,
              width: iconSize,
              fit: BoxFit.cover);
        }

      case CategoryTypeENUM.document:
        if (categoryData.image != null) {
          return MyNetworkImage(
            imageUrl: categoryData.image ?? "",
            appHeight: iconSize,
            appWidth: iconSize,
          );
        } else {
          // return Icon(
          //   Icons.insert_drive_file,
          //   size: 1.dp,
          // );
          return Image.asset(Assets.assetsIconsDoc,
              height: iconSize, width: iconSize, fit: BoxFit.cover);
        }
      case CategoryTypeENUM.ePublisher:
        if (categoryData.image != null) {
          return MyNetworkImage(
            imageUrl: categoryData.image ?? "",
            appHeight: iconSize,
            appWidth: iconSize,
          );
        } else {
          return Image.asset(Assets.assetsIconsEBook,
              height: iconSize, width: iconSize, fit: BoxFit.cover);
        }
      case CategoryTypeENUM.exam:
        if (categoryData.image != null) {
          return MyNetworkImage(
            imageUrl: categoryData.image ?? "",
            appHeight: iconSize,
            appWidth: iconSize,
          );
        } else {
          return Image.asset(Assets.assetsIconsExam,
              height: iconSize, width: iconSize, fit: BoxFit.cover);
        }

      default:
        return Icon(
          Icons.folder,
          size: iconSize,
        );
    }
  }

  Widget _detailsChips({num? typeId, num? fileTypeId, String? status}) {
    var categoryTypeViewData = categoryTypeData.data?.firstWhere(
      (element) => element.id == typeId,
    );
    var fileTypeViewData = fileTypeData.data?.firstWhere(
      (element) => element.id == fileTypeId,
    );
    return Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        runSpacing: 10,
        children: [
          Chip(
            padding: 8.horizontal,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: transparent),
                borderRadius: NkGeneralSize.nkCommonBorderRadius),
            labelPadding: 0.all,
            label: MyRegularText(
              label: categoryTypeViewData?.name ?? "",
              fontSize: NkFontSize.smallFont,
              color: successPrimary.withOpacity(.8),
            ),
            color: WidgetStatePropertyAll(successPrimary.withOpacity(.2)),
          ),
          Chip(
            padding: 8.horizontal,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: transparent),
                borderRadius: NkGeneralSize.nkCommonBorderRadius),
            labelPadding: 0.all,
            label: MyRegularText(
              label: fileTypeViewData?.typeName ?? "",
              fontSize: NkFontSize.smallFont,
              color: warningPrimary.withOpacity(.8),
            ),
            color: WidgetStatePropertyAll(warningPrimary.withOpacity(.2)),
          ),
          // Chip(
          //   padding: 8.horizontal,
          //   shape: RoundedRectangleBorder(
          //       side: const BorderSide(color: transparent),
          //       borderRadius: NkGeneralSize.nkCommonBorderRadius),
          //   labelPadding: 0.all,
          //   label: MyRegularText(
          //     label: status ?? "",
          //     fontSize: NkFontSize.smallFont,
          //     color: _statusColourHandle(status ?? "").withOpacity(.8),
          //   ),
          //   color: WidgetStatePropertyAll(
          //       _statusColourHandle(status ?? "").withOpacity(.2)),
          // ),
        ]);
  }

  // Color _statusColourHandle(String status) {
  //   switch (status.toUpperCase()) {
  //     case "ACTIVE":
  //       return infoPrimary;
  //     case "INACTIVE":
  //       return grey;
  //     case "DELETED":
  //       return errorColor;
  //     default:
  //       return infoPrimary;
  //   }
  // }

  Widget categoryList() {
    var fileType = convertStringToCategoryType(
        (selectedToggleType?.typeName ?? "").toUpperCase());
    if (fileType == CategoryTypeENUM.exam) {
      return quizDataList.when(
        context: context,
        successBuilder: (quizzzzList) {
          return ResponsiveGridList(
            minItemWidth: context.isMobile ? context.width : 200,
            minItemsPerRow: 1,
            maxItemsPerRow: 4,
            children: List.generate(quizzzzList.length, (index) {
              return quizComponent(quizzzzList[index], index);
            }).toList(),
          );
        },
      );
    }
    return categoryData.when(
      context: context,
      successBuilder: (boardList) {
        CategoryTypeENUM fileType = convertStringToCategoryType(
            (selectedToggleType?.typeName ?? "").toUpperCase());

        if (fileTypeENUM == CategoryTypeENUM.document ||
            fileTypeENUM == CategoryTypeENUM.ePublisher) {
          return NkWebDocumentViewer(
            id: "${boardList.firstOrNull?.fileUrl}",
            networkUrl: boardList.firstOrNull?.fileUrl,
          );
        }
        if (fileType == CategoryTypeENUM.folder) {
          return ResponsiveGridList(
            minItemWidth: context.isMobile ? context.width : 200,
            minItemsPerRow: 1,
            maxItemsPerRow: 4,
            children: List.generate(boardList.length, (index) {
              return boardComponent(boardList[index], index);
            }).toList(),
          );
        } else if (fileType == CategoryTypeENUM.document ||
            fileType == CategoryTypeENUM.ePublisher) {
          return ResponsiveGridList(
            minItemWidth: context.isMobile ? context.width : 200,
            minItemsPerRow: 1,
            maxItemsPerRow: 4,
            children: List.generate(boardList.length, (index) {
              return boardComponent(boardList[index], index);
            }).toList(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _fileTypeTab() {
    if (fileTypeENUM == CategoryTypeENUM.folder) {
      return fileTypeData.when(
        context: context,
        successBuilder: (p0) {
          var selectedIndex =
              p0.indexWhere((element) => element.id == selectedToggleType?.id);

          return Row(
            children: [
              MyCommnonContainer(
                isCardView: true,
                child: NkToggleButton(
                  initialIndex: selectedIndex.isNegative ? 0 : selectedIndex,
                  options: p0.map((e) => e.typeName ?? "").toList()
                    ..insert(0, "All"),
                  onToggle: (int val) {
                    if (val == 0) {
                      selectedToggleType = null;
                      callApi(
                        perentId: widget.categoryId?.toString(),
                        categoryLavel: widget.lavel?.toString(),
                      );
                    } else {
                      selectedToggleType = p0[val - 1];

                      if (convertStringToCategoryType(
                              selectedToggleType?.typeName ?? '') ==
                          CategoryTypeENUM.exam) {
                        callQuizApi(categoryId: widget.categoryId!.toString());
                      } else {
                        callApi(
                          perentId: widget.categoryId?.toString(),
                          categoryLavel: widget.lavel?.toString(),
                          fileTypeId: p0[val - 1].id?.toString(),
                        );
                      }
                    }
                  },
                ),
              ),
              5.space,
              IconButton.filledTonal(
                  padding: 0.all,
                  onPressed: () {
                    if (convertStringToCategoryType(
                            selectedToggleType?.typeName ?? '') ==
                        CategoryTypeENUM.exam) {
                      callQuizApi(categoryId: widget.categoryId!.toString());
                    } else {
                      callApi(
                        perentId: widget.categoryId?.toString(),
                        categoryLavel: widget.lavel?.toString(),
                        fileTypeId: selectedToggleType?.id?.toString(),
                      );
                    }
                  },
                  icon: const Icon(Icons.refresh, color: primaryIconColor))
            ],
          );
        },
      );
    } else {
      return const SizedBox();
    }
  }

  bool get isPerentCategory {
    if (widget.categoryId == null) {
      return true;
    } else {
      return false;
    }
  }

  _handleRoute(CategoryData catData, {bool isAddChild = true}) {
    var fileTypeViewData = fileTypeData.data?.firstWhere(
      (element) => element.id == catData.fileTypeId,
    );
    // var categoryTypeViewData = categoryTypeData.data?.firstWhere(
    //   (element) => element.id == catData.typeId,
    // );
    CategoryTypeENUM fileTypeENUM = convertStringToCategoryType(
        (fileTypeViewData?.typeName ?? "").toUpperCase());

    switch (fileTypeENUM) {
      case CategoryTypeENUM.folder:
        Map<String, String> pathData = {
          "id": catData.id.toString(),
          "lavel": ((catData.categoryLevel ?? 0) + 1).toString(),
          "fileType": fileTypeViewData?.typeName ?? "",
        };
        if (isAddChild) {
          childRoutesData.addAll([
            {
              "name": catData.name ?? "",
              "id": catData.id.toString(),
              "lavel": ((catData.categoryLevel ?? 0) + 1).toString(),
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
        break;
      case CategoryTypeENUM.document || CategoryTypeENUM.ePublisher:
        Map<String, String> pathData = {
          "id": catData.id.toString(),
          "lavel": ((catData.categoryLevel ?? 0) + 1).toString(),
          "fileType": fileTypeViewData?.typeName ?? "",
        };
        if (isAddChild) {
          childRoutesData.addAll([
            {
              "name": catData.name ?? "",
              "id": catData.id.toString(),
              "lavel": ((catData.categoryLevel ?? 0) + 1).toString(),
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
        break;

      default:
    }
  }

  _handleEditCategory(CategoryData catData, FileTypeData fileTypeData,
      CategoryTypeData categoryTypeData) {
    CategoryTypeENUM fileTypeENUM = convertStringToCategoryType(
        (fileTypeData.typeName ?? "").toUpperCase());

    switch (fileTypeENUM) {
      case CategoryTypeENUM.folder:
        showAdaptiveDialog(
          builder: (context) {
            return Center(
              child: MyScrollView(
                children: [
                  AddCategoryDiloag(
                    categoryDataModel: catData,
                    parentId: widget.categoryId?.toString(),
                    fileTypeModel: fileTypeData,
                    categoryType: fileTypeENUM,
                    onUpdated: (catData) {
                      callApi(
                        fileTypeId: catData?.fileTypeId!.toString(),
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
        break;
      case CategoryTypeENUM.document || CategoryTypeENUM.ePublisher:
        showAdaptiveDialog(
          builder: (context) {
            return Center(
              child: MyScrollView(
                children: [
                  AddCategoryDiloag(
                    categoryDataModel: catData,
                    parentId: widget.categoryId?.toString(),
                    fileTypeModel: fileTypeData,
                    categoryType: fileTypeENUM,
                    onUpdated: (catData) {
                      callApi(
                        fileTypeId: catData?.fileTypeId!.toString(),
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
        break;
      default:
    }
  }
}
