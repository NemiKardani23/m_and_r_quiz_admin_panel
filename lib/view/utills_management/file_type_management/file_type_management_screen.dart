import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/diloag/add_file_type_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../../export/___app_file_exporter.dart';

class FileTypeManagementScreen extends StatefulWidget {
  const FileTypeManagementScreen({super.key});

  @override
  State<FileTypeManagementScreen> createState() =>
      _FileTypeManagementScreenState();
}

class _FileTypeManagementScreenState extends State<FileTypeManagementScreen>
    with ChangeNotifier {
  DataHandler<List<FileTypeData>> fileTypeListData = DataHandler();

  @override
  initState() {
    getFileTypeList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  getFileTypeList() {
    ApiWorker().getFileTypeList().then(
      (value) {
        if (value != null && value.data.isNotEmpty && value.status == true) {
          setState(() {
            TempDataStore.tempFileTypeList.value = value.data;
            fileTypeListData.onSuccess(value.data);
          });
        } else {
          setState(() {
            TempDataStore.tempFileTypeList.value = null;
            fileTypeListData
                .onEmpty(value?.message ?? ErrorStrings.noDataFound);
          });
        }
      },
    ).catchError(
      (e) {
        setState(() {
          TempDataStore.tempFileTypeList.value = null;
          fileTypeListData.onError(ErrorStrings.oopsSomethingWentWrong);
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
              label: "$fileTypeStr $listStr",
              fontSize: NkFontSize.headingFont,
            ),
            MyThemeButton(
                padding: 10.horizontal,
                leadingIcon: const Icon(
                  Icons.add,
                  color: primaryIconColor,
                ),
                buttonText: "",
                onPressed: () {
                  showAdaptiveDialog(
                      context: context,
                      builder: (builder) {
                        return const AddFileTypeDiloag();
                      }).then(
                    (value) {
                      getFileTypeList();
                    },
                  );
                }),
          ],
        ),
        Flexible(child: categoryTypeList())
      ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
    );
  }

  Widget boardComponent(FileTypeData fileType, int index) {
    return MyCommnonContainer(
        isCardView: true,
        padding: nkRegularPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRegularText(
              align: TextAlign.start,
              label: fileType.typeName ?? "",
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
                                return AddFileTypeDiloag(
                                  fileTypeModel: fileType,
                                );
                              }).then(
                            (value) {
                              getFileTypeList();
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
                                  appBarTitle: fileType.typeName ?? "",
                                  onPressed: () async {
                                    await ApiWorker()
                                        .deleteFileType(
                                            id: fileType.id.toString())
                                        .whenComplete(() {
                                      NKToast.success(
                                          title:
                                              "${fileType.typeName} ${SuccessStrings.deletedSuccessfully}");
                                      setState(() {
                                        fileTypeListData.data?.removeAt(index);
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
                  backgroundColor: primaryColor,
                  thumbColor: selectionColor,
                  onValueChanged: (value) async {
                    var res = await ApiWorker()
                        .changeFileTypeStatus(
                      id: fileType.id.toString(),
                      status: value ?? fileType.status ?? 'active',
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
                          fileTypeListData.data?[index] =
                              fileType.copyWith(status: res);
                          // categoryTypeListData =
                          //     DataHandler(categoryTypeListData.data);
                        });
                      });
                    }
                  },
                  groupValue: fileType.status,
                  children: _statusTypeOptions(),
                )
              ],
            ),
          ],
        ));
  }

  Widget categoryTypeList() {
    return fileTypeListData.when(
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
