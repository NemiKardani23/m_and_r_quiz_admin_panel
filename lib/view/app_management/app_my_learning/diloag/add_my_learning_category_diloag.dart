import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/components/widget/my_learning_category_mode_option_select_widget.dart';
import 'package:m_and_r_quiz_admin_panel/components/widget/slide_mode_option_select_widget.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_add_fun.dart';
import 'package:m_and_r_quiz_admin_panel/service/firebase/firebase_edit_fun.dart';
import 'package:m_and_r_quiz_admin_panel/view/app_management/model/my_learning_category_list_model.dart';

class AddMyLearninCategoryDiloag extends StatefulWidget {
  final MyLearningCategoryListModel? categoryListModel;
  final Function(MyLearningCategoryListModel? updatedCategory)? onUpdate;
  const AddMyLearninCategoryDiloag(
      {super.key, this.categoryListModel, this.onUpdate});

  @override
  State<AddMyLearninCategoryDiloag> createState() =>
      _AddMyLearninCategoryDiloagState();
}

class _AddMyLearninCategoryDiloagState
    extends State<AddMyLearninCategoryDiloag> {
  String? selectedModeType = "Free";
  final TextEditingController _titleController = TextEditingController();
  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  MyLearningCategoryListModel? _categoryListModel;

  @override
  void initState() {
    _categoryListModel = widget.categoryListModel;
    loadModelData;
    super.initState();
  }

  get loadModelData {
    selectedModeType = _categoryListModel?.categoryMode ?? selectedModeType;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: _categoryListModel != null
            ? "$editStr $categoryStr"
            : "$addStr $categoryStr",
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: context.isMobile ? context.width : context.width * 0.25),
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: NkPickerWithPlaceHolder(
            pickType: FileType.image,
            imageUrl: _categoryListModel?.image ?? "",
            fileType: "image".toLowerCase(),
            onFilePicked: (imageBytes, imageName) {
              onImagePicked = (imageBytes, imageName);
            },
          ),
        ),
              const MyRegularText(label: categoryStr),
          MyFormField(
            controller: _titleController,
            labelText: categoryStr,
            isShowDefaultValidator: true,
            onChanged: (value) {
              _categoryListModel?.categoryName = value;
            },
          ),
        _selectMode(context),
        MyThemeButton(
            isLoadingButton: true,
            buttonText: _categoryListModel != null
                ? "$updateStr $categoryStr"
                : "$addStr $categoryStr",
            onPressed: () async {
              // if (widget.categoryListModel != null) {
              //   var data = await FirebaseEditFun().editAppMyLearningCategory(
              //       myLearningCategory: _categoryListModel!,
              //       image: onImagePicked?.$1,
              //       filename: onImagePicked?.$2);
              //   if (data != null) {
              //     NKToast.success(
              //         title:
              //             "$sliderStr ${SuccessStrings.updatedSuccessfully}");
              //     widget.onUpdate?.call(data);
              //   }
              // } else {
              //   if (onImagePicked == null) {
              //     NKToast.error(
              //         title: "$sliderStr ${ErrorStrings.selectImage}");
              //     return;
              //   }
              //   MyLearningCategoryListModel categoryData =
              //       MyLearningCategoryListModel(
              //     categoryMode: selectedModeType,
              //   );
              //   var data = await FirebaseAddFun().addMyLearningCategory(
              //       myLearningCategoryData: categoryData,
              //       image: onImagePicked!.$1,
              //       filename: onImagePicked!.$2);
              //   if (data != null) {
              //     NKToast.success(
              //         title: "$sliderStr ${SuccessStrings.addedSuccessfully}");
              //     widget.onUpdate?.call(data);
              //   }
              // }
            })
      ].addSpaceEveryWidget(space: nkSmallSizedBox),
    );
  }

  Widget _selectMode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyRegularText(label: "$selectStr $categoryStr $modeTypeStr"),
        nkExtraSmallSizedBox,
        MyLearningCategoryOptionSelectWidget(
          value: selectedModeType,
          onValueChanged: (p0) {
            if (_categoryListModel != null) {
              _categoryListModel!.categoryMode = p0;
            }
            setState(() {
              selectedModeType = p0;
            });
          },
        ),
      ],
    );
  }
}
