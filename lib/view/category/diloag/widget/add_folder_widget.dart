import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_enable_disable_widget.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/utills/image_upload/nk_multipart.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/widget/category_type_option_select_pick.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

class AddFolderDiloagWidget extends StatefulWidget {
  final CategoryData? categoryDataModel;
  final Function(CategoryData? catData)? onUpdated;
  final FileTypeData fileTypeModel;
  final String? parentId;
  const AddFolderDiloagWidget({
    super.key,
    this.categoryDataModel,
    this.onUpdated,
    required this.fileTypeModel,
    required this.parentId,
  });
  @override
  State<AddFolderDiloagWidget> createState() => _AddFolderDiloagWidgetState();
}

class _AddFolderDiloagWidgetState extends State<AddFolderDiloagWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController folderTitleController = TextEditingController();

  TextEditingController folderDescriptionController = TextEditingController();

  (
    Uint8List? imageBytes,
    String? imageName,
  )? onImagePicked;

  CategoryData? categoryDataModel;

  CategoryTypeData? selectedCategoryType;

  @override
  void initState() {
    if (widget.categoryDataModel != null) {
      categoryDataModel = widget.categoryDataModel;
      folderTitleController.text = widget.categoryDataModel?.name ?? "";
      folderDescriptionController.text =
          widget.categoryDataModel?.description ?? "";

      selectedCategoryType = CategoryTypeData.fromJson({
        "id": widget.categoryDataModel?.typeId,
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      titlePadding: 16.horizontal,
      title: MyAppBar(
        heading: categoryDataModel != null
            ? "$editStr $folderStr"
            : "$addStr $folderStr",
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth:
                  context.isMobile ? context.width : context.width * 0.35),
          child: _body(context),
        ),
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
              imageUrl: categoryDataModel?.fileUrl ?? "",
              fileType: "image",
              onFilePicked: (imageBytes, imageName) {
                onImagePicked = (imageBytes, imageName);
              },
            ),
          ),
          const MyRegularText(label: "$folderStr $nameStr"),
          MyFormField(
            controller: folderTitleController,
            labelText: nameStr,
            isShowDefaultValidator: true,
            onChanged: (value) {
              categoryDataModel = categoryDataModel?.copyWith(name: value);
            },
          ),
          const MyRegularText(label: "$folderStr $descriptionStr"),
          MyFormField(
            controller: folderDescriptionController,
            labelText: descriptionStr,
            isShowDefaultValidator: false,
            onChanged: (value) {
              categoryDataModel =
                  categoryDataModel?.copyWith(description: value);
            },
          ),
          const MyRegularText(label: "$folderStr $categoryTypeStr"),
          NkEnableDisableWidget(
            isEnable: categoryDataModel == null,
            child: CategoryTypeOptionSelectWidget(
              onValueChanged: (categoryType) {
                setState(() {
                  selectedCategoryType = categoryType;
                });
              },
              value: selectedCategoryType,
            ),
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: categoryDataModel != null
                  ? "$updateStr $folderStr"
                  : "$addStr $folderStr",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (widget.categoryDataModel != null) {
                    ApiWorker()
                        .updateCategory(
                          fileTypeId: categoryDataModel!.fileTypeId.toString(),
                          typeId: categoryDataModel!.typeId.toString(),
                      categoryId: categoryDataModel!.id.toString(),
                      categoryImage: NKMultipart.getMultipartImageBytesNullable(
                          name: onImagePicked?.$2 ?? "",
                          imageBytes: onImagePicked?.$1),
                      name: categoryDataModel?.name ?? "",
                      parentId: categoryDataModel?.parentId.toString(),
                      description: categoryDataModel?.description ?? "",
                    )
                        .then((value) {
                      if (value != null && value.status == true) {
                        widget.onUpdated!(widget.categoryDataModel);
                        NKToast.success(
                            description:
                                "${widget.fileTypeModel.typeName} ${SuccessStrings.updatedSuccessfully}");
                        Navigator.pop(context);
                      }
                    });
                  } else {
                    ApiWorker()
                        .addCategory(
                      categoryImage: NKMultipart.getMultipartImageBytesNullable(
                          name: onImagePicked?.$2 ?? "",
                          imageBytes: onImagePicked?.$1),
                      name: folderTitleController.text,
                      parentId: widget.parentId,
                      typeId: selectedCategoryType!.id.toString(),
                      fileTypeId: widget.fileTypeModel.id.toString(),
                      description: folderDescriptionController.text,
                    )
                        .then((value) {
                      if (value != null && value.status == true) {
                        widget.onUpdated!(widget.categoryDataModel);
                        NKToast.success(
                            description:
                                "${widget.fileTypeModel.typeName} ${SuccessStrings.addedSuccessfully}");
                        Navigator.pop(context);
                      }
                    });
                  }
                }
              })
        ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
      ),
    );
  }
}
