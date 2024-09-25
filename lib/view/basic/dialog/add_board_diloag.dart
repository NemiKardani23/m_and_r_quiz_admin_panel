import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_add_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_edit_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/basic/model/board_list_model.dart';

class AddBoardDiloag extends StatefulWidget {
  final BoardListModel? boardListModel;
  final Function(BoardListModel? board)? onBoardUpdated;
  const AddBoardDiloag({super.key, this.boardListModel, this.onBoardUpdated});

  @override
  State<AddBoardDiloag> createState() => _AddBoardDiloagState();
}

class _AddBoardDiloagState extends State<AddBoardDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController boardController = TextEditingController();
  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  @override
  void initState() {
    if (widget.boardListModel != null) {
      boardController.text = widget.boardListModel!.boardName ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: widget.boardListModel != null
            ? "$editStr $boardStr"
            : "$addStr $boardStr",
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
              imageUrl: widget.boardListModel?.image ?? "",
              fileType: "image",
              onFilePicked: (imageBytes, imageName) {
                onImagePicked = (imageBytes, imageName);
              },
            ),
          ),
          const MyRegularText(label: boardStr),
          MyFormField(
            controller: boardController,
            labelText: boardStr,
            isShowDefaultValidator: true,
            onChanged: (value) {
              widget.boardListModel?.boardName = value;
            },
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: widget.boardListModel != null
                  ? "$updateStr $boardStr"
                  : "$addStr $boardStr",
              onPressed: () async {
                // if (formKey.currentState!.validate()) {
                //   if (widget.boardListModel != null) {
                //     await FirebaseEditFun()
                //         .editBoardDetails(
                //       bordModel: widget.boardListModel!,
                //       boardId: widget.boardListModel!.boardId!,
                //       image: onImagePicked?.$1,
                //       filename: onImagePicked?.$2,
                //     )
                //         .then(
                //       (value) {
                //         NKToast.success(
                //             title:
                //                 "$boardStr ${SuccessStrings.addedSuccessfully}");
                //         widget.onBoardUpdated?.call(value);
                //         AppRoutes.navigator.pop();
                //       },
                //     );
                //   } else {
                //     await FirebaseAddFun()
                //         .addBoard(
                //             boardName: boardController.text,
                //             image: onImagePicked?.$1,
                //             filename: onImagePicked?.$2)
                //         .then(
                //       (value) {
                //         NKToast.success(
                //             title:
                //                 "$boardStr ${SuccessStrings.addedSuccessfully}");
                //         Navigator.pop(context);
                //         widget.onBoardUpdated?.call(value);
                //       },
                //     );
                //   }
                // }
              })
        ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
      ),
    );
  }
}
