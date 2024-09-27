import 'dart:convert';

import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
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

  List<Map<String, String>> childRoutesData = [];

  @override
  initState() {
    super.initState();
    callApi(
      perentId: widget.categoryId?.toString(),
      categoryLavel: widget.lavel?.toString(),
    );
    childRoutesData = NkCommonFunction.convertStringToListMap(
            widget.routeChildrenPath ?? "") ??
        [];
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
        MyCommnonContainer(
          isCardView: true,
          margin: nkRegularPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          AppRoutes.navigator
                              .pushReplacementNamed(AppRoutes.categoryScreen);
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
                          MyRegularText(label: mapData["name"].toString()),
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
        Flexible(child: boardList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  Widget boardComponent(CategoryData categoryData, int index) {
    return InkResponse(
      onDoubleTap: () {
        _handleRoute(categoryData);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder,
            size: 1.dp,
          ),
          MyRegularText(label: categoryData.name ?? "")
        ].addSpaceEveryWidget(space: 5.space),
      ),
    );
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
