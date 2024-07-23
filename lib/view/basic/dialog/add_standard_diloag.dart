import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/dropdown/nk_serchable_dropdown_menu.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_add_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_edit_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/standard_list_model.dart';

class AddStandardDiloag extends StatefulWidget {
  final StandardListModel? standardListModel;
  final List<BoardListModel> boardList;
  final Function(StandardListModel? standard)? onBoardUpdated;
  const AddStandardDiloag(
      {super.key,
      this.standardListModel,
      this.onBoardUpdated,
      required this.boardList});

  @override
  State<AddStandardDiloag> createState() => _AddStandardDiloagState();
}

class _AddStandardDiloagState extends State<AddStandardDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController standardController = TextEditingController();
  BoardListModel? newSelectedBoard;
  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  @override
  void initState() {
    if (widget.standardListModel != null) {
      standardController.text = widget.standardListModel!.standardName ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: widget.standardListModel != null
            ? "$editStr $standardStr"
            : "$addStr $standardStr",
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
              imageUrl: widget.standardListModel?.image ?? "",
              onImagePicked: (imageBytes, imageName) {
                onImagePicked = (imageBytes, imageName);
              },
            ),
          ),
          const MyRegularText(label: boardStr),
          NkSearchableDropDownMenu<BoardListModel>(
            hintText: "$selectStr $boardStr",
            initialSelection: widget.boardList.firstWhere(
              (element) => element.boardId == widget.standardListModel?.boardId,
              orElse: () => BoardListModel(),
            ),
            onSelected: (p0) {
              newSelectedBoard = p0;
            },
            dropdownMenuEntries: List.generate(
                widget.boardList.length,
                (index) => DropdownMenuEntry<BoardListModel>(
                      value: widget.boardList[index],
                      label: widget.boardList[index].boardName ?? "",
                    )),
          ),
          const MyRegularText(label: standardStr),
          MyFormField(
            controller: standardController,
            labelText: standardStr,
            isShowDefaultValidator: true,
            onChanged: (value) {
              widget.standardListModel?.standardName = value;
            },
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: widget.standardListModel != null
                  ? "$updateStr $standardStr"
                  : "$addStr $standardStr",
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    if (widget.standardListModel != null) {
                      await FirebaseEditFun()
                          .editStandardDetails(
                        standardModel: widget.standardListModel!,
                        newBoardId: newSelectedBoard?.boardId,
                        image: onImagePicked?.$1,
                        filename: onImagePicked?.$2,
                        standardId: widget.standardListModel!.standardId!,
                      )
                          .then(
                        (value) {
                          NKToast.success(
                              title:
                                  "$boardStr ${SuccessStrings.addedSuccessfully}");
                          AppRoutes.navigator.pop();
                          widget.onBoardUpdated?.call(value);
                        },
                      );
                    } else {
                      if (newSelectedBoard != null) {
                        await FirebaseAddFun()
                            .addStandard(
                                boardId: newSelectedBoard!.boardId!,
                                standardName: standardController.text,
                                image: onImagePicked?.$1,
                                filename: onImagePicked?.$2)
                            .then(
                          (value) {
                            NKToast.success(
                                title:
                                    "$boardStr ${SuccessStrings.addedSuccessfully}");
                            Navigator.pop(context);
                            widget.onBoardUpdated?.call(value);
                          },
                        );
                      } else if (newSelectedBoard == null) {
                        NKToast.warning(
                            title: "${ErrorStrings.select} $boardStr");
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
