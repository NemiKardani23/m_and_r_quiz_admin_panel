import 'package:file_picker/file_picker.dart';
import 'package:m_and_r_quiz_admin_panel/components/app_bar/my_app_bar.dart';
import 'package:m_and_r_quiz_admin_panel/components/nk_image_picker_with_placeholder/nk_image_picker_with_placeholder.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';
import 'package:m_and_r_quiz_admin_panel/service/api_worker.dart';
import 'package:m_and_r_quiz_admin_panel/utills/image_upload/nk_multipart.dart';
import 'package:m_and_r_quiz_admin_panel/view/category/model/category_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/model/category_type_response.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/category_type_management/widget/category_type_option_select_pick.dart';
import 'package:m_and_r_quiz_admin_panel/view/utills_management/file_type_management/model/file_type_response.dart';

class AddDocumentDiloag extends StatefulWidget {
  final CategoryData? categoryDataModel;
  final Function(CategoryData? catData)? onUpdated;
  final FileTypeData fileTypeModel;
  final    String? parentId;

  const AddDocumentDiloag({
    super.key,
    this.categoryDataModel,
    this.onUpdated,
    required this.fileTypeModel, this.parentId,
  });
  @override
  State<AddDocumentDiloag> createState() => _AddDocumentDiloagState();
}

class _AddDocumentDiloagState extends State<AddDocumentDiloag> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController folderTitleController = TextEditingController();

  TextEditingController folderDescriptionController = TextEditingController();

  (
    Uint8List? imageBytes,
    String? imageName,
  )? onThumbImagePicked;

  (
    Uint8List? imageBytes,
    String? imageName,
  )? onDocPicked;

  CategoryData? categoryDataModel;

  CategoryTypeData? selectedCategoryType;

  @override
  void initState() {
    if (widget.categoryDataModel != null) {
      categoryDataModel = widget.categoryDataModel;
      folderTitleController.text = widget.categoryDataModel?.name ?? "";
      folderDescriptionController.text =
          widget.categoryDataModel?.description ?? "";
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
            ? "$editStr ${widget.fileTypeModel.typeName}"
            : "$addStr ${widget.fileTypeModel.typeName}",
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
              pickType: FileType.image,
              lableText: "${widget.fileTypeModel.typeName} $thumbImageStr",
              imageUrl: categoryDataModel?.image ?? "",
              fileType: "image",
              onFilePicked: (imageBytes, imageName) {
                onThumbImagePicked = (imageBytes, imageName);
              },
            ),
          ),
          const Divider(
            color: dividerColor,
          ),
          Center(
            child: NkPickerWithPlaceHolder(
              pickType: FileType.any,
              lableText: "${widget.fileTypeModel.typeName} $fileStr *",
              imageUrl: categoryDataModel?.fileUrl ?? "",
              fileType: "file",
              onFilePicked: (imageBytes, imageName) {
                onDocPicked = (imageBytes, imageName);
              },
            ),
          ),
          MyRegularText(label: "${widget.fileTypeModel.typeName} $nameStr"),
          MyFormField(
            controller: folderTitleController,
            labelText: nameStr,
            isShowDefaultValidator: true,
            onChanged: (value) {
              categoryDataModel = categoryDataModel?.copyWith(name: value);
            },
          ),
          MyRegularText(
              label: "${widget.fileTypeModel.typeName} $descriptionStr"),
          MyFormField(
            controller: folderDescriptionController,
            labelText: descriptionStr,
            isShowDefaultValidator: false,
            onChanged: (value) {
              categoryDataModel =
                  categoryDataModel?.copyWith(description: value);
            },
          ),
          MyRegularText(
              label: "${widget.fileTypeModel.typeName} $categoryTypeStr"),
          CategoryTypeOptionSelectWidget(
            onValueChanged: (categoryType) {
              setState(() {
                selectedCategoryType = categoryType;
              });
            },
            value: selectedCategoryType,
          ),
          nkExtraSmallSizedBox,
          MyThemeButton(
              isLoadingButton: true,
              buttonText: categoryDataModel != null
                  ? "$updateStr ${widget.fileTypeModel.typeName}"
                  : "$addStr ${widget.fileTypeModel.typeName}",
              onPressed: () async {
                  if (onDocPicked == null) {
                      NKToast.warning(
                          description:
                              "Please select ${widget.fileTypeModel.typeName} $fileStr");
                      return;
                    }
                    if (selectedCategoryType == null) {
                      NKToast.warning(
                          description:
                              "Please select ${widget.fileTypeModel.typeName} $categoryTypeStr");
                      return;
                    }
                if (formKey.currentState!.validate()) {
                  if (widget.categoryDataModel != null) {
                  } else {
                  
                    await ApiWorker()
                        .addCategory(
                      categoryImage: NKMultipart.getMultipartImageBytesNullable(
                          name: onThumbImagePicked?.$2 ?? "",
                          imageBytes: onThumbImagePicked?.$1),
                      file: NKMultipart.getMultipartImageBytesNullable(
                          name: onDocPicked?.$2 ?? "",
                          imageBytes: onDocPicked?.$1),
                        name: folderTitleController.text,
                      parentId: widget.parentId,
                      typeId: selectedCategoryType!.id.toString(),
                      fileTypeId: widget.fileTypeModel.id.toString(),
                      description: folderDescriptionController.text,
                    )
                        .then(
                      (value) {
                        if (value != null && value.status == true) {
                          widget.onUpdated?.call(categoryDataModel);
                          NKToast.success(
                              description:
                                  "${widget.fileTypeModel.typeName} ${SuccessStrings.addedSuccessfully}");
                          Navigator.pop(context);
                        }
                      },
                    );
                  }
                }
              })
        ].addSpaceEveryWidget(space: nkExtraSmallSizedBox),
      ),
    );
  }
}
