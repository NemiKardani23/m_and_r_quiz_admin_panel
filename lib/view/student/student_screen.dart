import 'package:m_and_r_quiz_admin_panel/components/common_diloag/my_delete_dialog.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_network_image.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/student/diloag/add_student_diloag.dart';
import 'package:m_and_r_quiz_admin_panel/view/student/model/student_list_model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  DataHandler<List<StudentListModel>> studentListData = DataHandler();
  DataHandler<List<BoardListModel>> boardListData = DataHandler();

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

  getStudentData({bool isRefresh = false}) async {
    studentListData.startLoading();
    // TempDataStore.studentList().then((value) {
    //   if (value != null && value.isNotEmpty) {
    //     setState(() {
    //       studentListData.onSuccess(value);
    //     });
    //   } else {
    //     setState(() {
    //       studentListData.onEmpty(ErrorStrings.noDataFound);
    //     });
    //   }
    // }).catchError((error, stackTrace) {
    //   setState(() {
    //     studentListData.onError(error.toString());
    //   });
    // });
  }

  @override
  void initState() {
    getBoardData();
    getStudentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(context: context, myBody: _body(context));
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyRegularText(
              label: studentStr,
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
                  buttonText: "$addStr $standardStr",
                  onPressed: () async {
                    showAdaptiveDialog<StudentListModel?>(
                        context: context,
                        builder: (builder) {
                          return AddStudentDiloag(
                            boardList: boardListData.data ?? [],
                            onUpdated: (student) {
                              // try {
                              //   AppRoutes.navigator.pop();
                              //   setState(() {
                              //     if (student != null &&
                              //         studentListData.data?.isNotEmpty ==
                              //             true) {
                              //       TempDataStore.tempStudentList.value
                              //           ?.add(student);
                              //       studentListData.onSuccess(
                              //           TempDataStore.tempStudentList.value ??
                              //               []);
                              //       return;
                              //     } else if (student != null) {
                              //       studentListData.onSuccess([student]);
                              //       TempDataStore.tempStudentList.value
                              //           ?.add(student);
                              //       return;
                              //     }
                              //   });
                              // } on Exception catch (e) {
                              //   nkDevLog("EXCEPTION STUDENT : ${e.toString()}",
                              //       error: e.toString());
                              // }
                            },
                          );
                        }).then((val) {});
                  }),
            )
          ],
        ),
        nkMediumSizedBox,
        Expanded(child: _studentList()),
      ],
    );
  }

  Widget _studentList() {
    return studentListData.when(
      context: context,
      successBuilder: (studentList) {
        return ResponsiveGridList(
          minItemWidth: context.isMobile ? context.width : 300,
          minItemsPerRow: 1,
          maxItemsPerRow: 4,
          children: List.generate(studentList.length, (index) {
            return studentComponent(studentList[index], index);
          }).toList(),
        );
      },
    );
  }

  Widget studentComponent(StudentListModel student, int index) {
    return MyCommnonContainer(
        isCardView: true,
        padding: nkRegularPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  MyNetworkImage(imageUrl: student.image ?? ""),
                  nkExtraSmallSizedBox,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyRegularText(
                          align: TextAlign.start,
                          label: student.studentName ?? "",
                        ),
                        Flexible(
                          child: MyRegularText(
                            align: TextAlign.start,
                            label: student.createdAt ?? "",
                            fontSize: NkFontSize.extraSmallFont,
                            color: secondaryTextColor,
                          ),
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
                            return AddStudentDiloag(
                              studentListModel: student,
                              boardList: boardListData.data ?? [],
                              onUpdated: (student) {
                                // TempDataStore.tempStudentList.value![index] =
                                //     student!;
                                // setState(() {
                                //   studentListData.onSuccess(
                                //       TempDataStore.tempStudentList.value ??
                                //           []);
                                // });
                              },
                            );
                          }).whenComplete(() => setState(() {}));
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showAdaptiveDialog(
                          context: context,
                          builder: (builder) {
                            return MyDeleteDialog(
                              appBarTitle: student.studentName ?? "",
                              onPressed: () async {
                                // await FirebaseDeleteFun()
                                //     .deleteStudent(student.studentId ?? "",
                                //         imageUrl: student.image)
                                //     .whenComplete(() {
                                //   NKToast.success(
                                //       title:
                                //           "${student.studentName} ${SuccessStrings.deletedSuccessfully}");
                                //   setState(() {
                                //     TempDataStore.tempStudentList.value
                                //         ?.removeAt(index);
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
}
