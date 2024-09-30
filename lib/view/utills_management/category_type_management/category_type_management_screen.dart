import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/components/common_diloag/my_delete_dialog.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/diloag/add_category_type_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../../export/___app_file_exporter.dart';

class CategoryTypeManagementScreen extends StatefulWidget {
  const CategoryTypeManagementScreen({super.key});

  @override
  State<CategoryTypeManagementScreen> createState() =>
      _CategoryTypeManagementScreenState();
}

class _CategoryTypeManagementScreenState
    extends State<CategoryTypeManagementScreen> with ChangeNotifier {
  DataHandler<List<CategoryTypeData>> categoryTypeListData = DataHandler();

  @override
  initState() {
    getCategoryTypeList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  getCategoryTypeList() {
    ApiWorker().getCategoryTypeList().then(
      (value) {
        if (value != null && value.data.isNotEmpty && value.status) {
          setState(() {
            TempDataStore.tempCategoryTypeList.value = value.data;
            categoryTypeListData.onSuccess(value.data);
          });
        } else {
          setState(() {
            TempDataStore.tempCategoryTypeList.value = null;
            categoryTypeListData
                .onEmpty(value?.message ?? ErrorStrings.noDataFound);
          });
        }
      },
    ).catchError(
      (e) {
        setState(() {
          TempDataStore.tempCategoryTypeList.value = null;
          categoryTypeListData.onError(ErrorStrings.oopsSomethingWentWrong);
        });
      },
    );
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
              label: "$categoryTypeStr $listStr",
              fontSize: NkFontSize.headingFont,
            ),
            MyThemeButton(
                padding: 10.horizontal,
                leadingIcon: const Icon(
                  Icons.add,
                  color: secondaryIconColor,
                ),
                buttonText: "$addStr $categoryTypeStr",
                onPressed: () {
                  showAdaptiveDialog(
                      context: context,
                      builder: (builder) {
                        return const AddCategoryTypeDiloag();
                      }).then(
                    (value) {
                      getCategoryTypeList();
                    },
                  );
                }),
          ],
        ),
        Flexible(child: categoryTypeList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  Widget boardComponent(CategoryTypeData catType, int index) {
    return MyCommnonContainer(
        isCardView: true,
        padding: nkRegularPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyRegularText(
                    align: TextAlign.start,
                    label: catType.name,
                  ),
                  MyRegularText(
                    label: catType.createdAt?.toIso8601String() ?? "",
                    fontSize: NkFontSize.extraSmallFont,
                    color: secondaryTextColor,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Wrap(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await showAdaptiveDialog(
                              context: context,
                              builder: (builder) {
                                return AddCategoryTypeDiloag(
                                  categoryTypeModel: catType,
                                );
                              }).then(
                            (value) {
                              getCategoryTypeList();
                            },
                          );
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          showAdaptiveDialog(
                              context: context,
                              builder: (builder) {
                                return MyDeleteDialog(
                                  appBarTitle: catType.name,
                                  onPressed: () async {
                                    await ApiWorker()
                                        .deleteCategoryType(
                                            id: catType.id.toString())
                                        .whenComplete(() {
                                      NKToast.success(
                                          title:
                                              "${catType.name} ${SuccessStrings.deletedSuccessfully}");
                                      setState(() {
                                        categoryTypeListData.data
                                            ?.removeAt(index);
                                      });
                                    });
                                  },
                                );
                              }).then((value) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.delete_forever)),
                  ],
                ),
                CupertinoSlidingSegmentedControl<String>(
                  onValueChanged: (value) async {
                    var res = await ApiWorker()
                        .changeCategoryTypeStatus(
                      id: catType.id.toString(),
                      status: value ?? catType.status,
                    )
                        .then((res) {
                      if (res != null && res.status) {
                        NKToast.success(description: res.message);
                        return value;
                      }
                    });
                    if (res != null) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        setState(() {
                          categoryTypeListData.data?[index] =
                              catType.copyWith(status: res);
                          // categoryTypeListData =
                          //     DataHandler(categoryTypeListData.data);
                        });
                      });
                    }
                  },
                  groupValue: catType.status,
                  children: _statusTypeOptions(),
                )
              ],
            ),
          ],
        ));
  }

  Widget categoryTypeList() {
    return categoryTypeListData.when(
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
}
