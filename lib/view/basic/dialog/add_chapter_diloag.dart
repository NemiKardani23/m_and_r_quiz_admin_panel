import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_enable_disable_widget.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_add_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_edit_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/chapter_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';

class AddChapterDiloag extends StatefulWidget {
  final ChapterListModel? chapterListModel;
  final List<BoardListModel> boardList;
  final Function(ChapterListModel? standard)? onChapterUpdated;
  const AddChapterDiloag({
    super.key,
    this.chapterListModel,
    this.onChapterUpdated,
    required this.boardList,
  });

  @override
  State<AddChapterDiloag> createState() => _AddChapterDiloagState();
}

class _AddChapterDiloagState extends State<AddChapterDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController chapterController = TextEditingController();
  final DataHandler<List<StandardListModel>> standardList = DataHandler();
  final DataHandler<List<SubjectListModel>> subjectList = DataHandler();

  BoardListModel? newSelectedBoard;
  StandardListModel? newSelectedStandard;
  SubjectListModel? newSelectedSubject;
  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  getStandardData(String boardId) async {
    setState(() {
      standardList.startLoading();
    });
    TempDataStore.standardList(boardId).then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          standardList.onSuccess(value);
        });
      } else {
        setState(() {
          standardList.onEmpty(ErrorStrings.noDataFound);
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        standardList.onError(error.toString());
      });
    });
  }

  getSubjectData(String boardId, String standardId) async {
    setState(() {
      subjectList.startLoading();
    });
    TempDataStore.subjectList(boardId, standardId).then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          subjectList.onSuccess(value);
        });
      } else {
        setState(() {
          subjectList.onEmpty(ErrorStrings.noDataFound);
        });
      }
    }).catchError((error, stackTrace) {
      setState(() {
        subjectList.onError(error.toString());
      });
    });
  }

  @override
  void initState() {
    if (widget.chapterListModel != null) {
      chapterController.text = widget.chapterListModel!.chapterName ?? "";

      loadDropDownData();
    }
    super.initState();
  }

  loadDropDownData() {
    getStandardData(widget.chapterListModel?.boardId ?? "");
    getSubjectData(widget.chapterListModel?.boardId ?? "",
        widget.chapterListModel?.standardId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: widget.chapterListModel != null
            ? "$editStr $subjectStr"
            : "$addStr $subjectStr",
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.width * 0.25),
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: NkImagePickerWithPlaceHolder(
              imageUrl: widget.chapterListModel?.image ?? "",
              onImagePicked: (imageBytes, imageName) {
                onImagePicked = (imageBytes, imageName);
              },
            ),
          ),
          const MyRegularText(label: boardStr),
          NkSearchableDropDownMenu<BoardListModel>(
            hintText: "$selectStr $boardStr",
            initialSelection: widget.boardList.firstWhere(
              (element) =>
                  element.boardId
                      ?.contains(widget.chapterListModel?.boardId ?? "") ??
                  false,
              orElse: () => BoardListModel(),
            ),
            onSelected: (p0) {
              newSelectedBoard = p0;
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
                          widget.chapterListModel?.standardId,
                      orElse: () => StandardListModel(),
                    ),
                    hintText: "$selectStr $standardStr",
                    onSelected: (val) {
                      newSelectedStandard = val;
                      getSubjectData(val!.boardId!, val.standardId!);
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
          const MyRegularText(label: subjectStr),
          subjectList.when(
              context: context,
              successBuilder: (subjectList) {
                return NkEnableDisableWidget(
                  isEnable: subjectList.isNotEmpty,
                  child: NkSearchableDropDownMenu<SubjectListModel>(
                    initialSelection: subjectList.firstWhere(
                      (element) =>
                          element.subjectId ==
                          widget.chapterListModel?.subjectId,
                      orElse: () => SubjectListModel(),
                    ),
                    hintText: "$selectStr $subjectStr",
                    onSelected: (val) {
                      newSelectedSubject = val;
                    },
                    dropdownMenuEntries: List.generate(
                        subjectList.length,
                        (index) => DropdownMenuEntry<SubjectListModel>(
                              value: subjectList[index],
                              label: subjectList[index].subjectName ?? "",
                            )),
                  ),
                );
              }),
          const MyRegularText(label: chapterStr),
          MyFormField(
            controller: chapterController,
            labelText: chapterStr,
            isShowDefaultValidator: true,
            onChanged: (value) {
              widget.chapterListModel?.chapterName = value;
            },
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: widget.chapterListModel != null
                  ? "$updateStr $chapterStr"
                  : "$addStr $chapterStr",
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    if (widget.chapterListModel != null) {
                      await FirebaseEditFun()
                          .editChapterDetails(
                        chapterModel: widget.chapterListModel!,
                        newBoardId: newSelectedBoard?.boardId,
                        newStandardId: newSelectedStandard?.standardId,
                        newSubjectId: newSelectedSubject?.subjectId,
                        image: onImagePicked?.$1,
                        filename: onImagePicked?.$2,
                        chapterId: widget.chapterListModel!.chapterId!,
                      )
                          .then(
                        (value) {
                          NKToast.success(
                              title:
                                  "$boardStr ${SuccessStrings.addedSuccessfully}");
                          AppRoutes.navigator.pop();
                          widget.onChapterUpdated?.call(value);
                        },
                      );
                    } else {
                      if (newSelectedBoard != null &&
                          newSelectedStandard != null &&
                          newSelectedSubject != null) {
                        await FirebaseAddFun()
                            .addChapter(
                                standardId: newSelectedStandard!.standardId!,
                                boardId: newSelectedBoard!.boardId!,
                                chapterName: chapterController.text,
                                subjectId: newSelectedSubject!.subjectId!,
                                image: onImagePicked?.$1,
                                filename: onImagePicked?.$2)
                            .then(
                          (value) {
                            NKToast.success(
                                title:
                                    "$boardStr ${SuccessStrings.addedSuccessfully}");
                            Navigator.pop(context);
                            widget.onChapterUpdated?.call(value);
                          },
                        );
                      } else if (newSelectedBoard == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $boardStr");
                      } else if (newSelectedStandard == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $standardStr");
                      } else if (newSelectedSubject == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $subjectStr");
                      }
                    }
                  }
                } on Exception catch (e) {
                  nkDevLog("ADD STANDARD ERROR : ${e.toString()}");
                }
              })
        ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
      ),
    );
  }
}
