import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_enable_disable_widget.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/local_storage/temp_data_store/temp_data_store.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_add_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_edit_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/subject_list_model.dart';

class AddSubjectDiloag extends StatefulWidget {
  final SubjectListModel? subjectListModel;
  final List<BoardListModel> boardList;
  final Function(SubjectListModel? standard)? onSubjectUpdated;
  const AddSubjectDiloag({
    super.key,
    this.subjectListModel,
    this.onSubjectUpdated,
    required this.boardList,
  });

  @override
  State<AddSubjectDiloag> createState() => _AddSubjectDiloagState();
}

class _AddSubjectDiloagState extends State<AddSubjectDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  final DataHandler<List<StandardListModel>> standardList = DataHandler();

  BoardListModel? newSelectedBoard;
  StandardListModel? newSelectedStandard;
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

  @override
  void initState() {
    if (widget.subjectListModel != null) {
      subjectController.text = widget.subjectListModel!.subjectName ?? "";
      getStandardData(widget.subjectListModel!.boardId ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      scrollable: true,
      title: MyAppBar(
        heading: widget.subjectListModel != null
            ? "$editStr $subjectStr"
            : "$addStr $subjectStr",
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: context.isMobile ? context.width : context.width * 0.35),
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
            child: NkPickerWithPlaceHolder(
              imageUrl: widget.subjectListModel?.image ?? "",
              onFilePicked: (imageBytes, imageName) {
                onImagePicked = (imageBytes, imageName);
              },
              fileType: "image",
            ),
          ),
          const MyRegularText(label: boardStr),
          NkSearchableDropDownMenu<BoardListModel>(
            hintText: "$selectStr $boardStr",
            initialSelection: widget.boardList.firstWhere(
              (element) => element.boardId == widget.subjectListModel?.boardId,
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
                          widget.subjectListModel?.standardId,
                      orElse: () => StandardListModel(),
                    ),
                    hintText: "$selectStr $standardStr",
                    onSelected: (val) {
                      newSelectedStandard = val;
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
          MyFormField(
            controller: subjectController,
            labelText: standardStr,
            isShowDefaultValidator: true,
            onChanged: (value) {
              widget.subjectListModel?.subjectName = value;
            },
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: widget.subjectListModel != null
                  ? "$updateStr $subjectStr"
                  : "$addStr $subjectStr",
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    if (widget.subjectListModel != null) {
                      await FirebaseEditFun()
                          .editSubjectDetails(
                        subjectModel: widget.subjectListModel!,
                        newBoardId: newSelectedBoard?.boardId,
                        newStandardId: newSelectedStandard?.standardId,
                        image: onImagePicked?.$1,
                        filename: onImagePicked?.$2,
                        subjectId: widget.subjectListModel!.subjectId!,
                      )
                          .then(
                        (value) {
                          NKToast.success(
                              title:
                                  "$boardStr ${SuccessStrings.addedSuccessfully}");
                          AppRoutes.navigator.pop();
                          widget.onSubjectUpdated?.call(value);
                        },
                      );
                    } else {
                      if (newSelectedBoard != null &&
                          newSelectedStandard != null) {
                        await FirebaseAddFun()
                            .addSubject(
                                standardId: newSelectedStandard!.standardId!,
                                boardId: newSelectedBoard!.boardId!,
                                subjectName: subjectController.text,
                                image: onImagePicked?.$1,
                                filename: onImagePicked?.$2)
                            .then(
                          (value) {
                            NKToast.success(
                                title:
                                    "$boardStr ${SuccessStrings.addedSuccessfully}");
                            Navigator.pop(context);
                            widget.onSubjectUpdated?.call(value);
                          },
                        );
                      } else if (newSelectedBoard == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $boardStr");
                      } else if (newSelectedStandard == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $standardStr");
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
